require 'line/bot'

class MessageController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :client, only: [:callback]
  before_action :request_signature, only: [:callback]

  def callback
    unless signature_validate?
      render status: 400, json: { message: 'Bad Request' }
    end

    events    = Line::MessageEventParseService.new(body: body, client: client).call!
    _service  = Line::MessageSendService.new(events: events, client: client).call!

    render status: 200, json: { message: 'OK' }
  end

  private

  attr_reader :body, :signature

  def signature_validate?
    client.validate_signature(body, signature)
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = LINE_CHANNEL_SECRET
      config.channel_token = LINE_CHANNEL_TOKEN
    end
  end

  def request_signature
    @body = request.body.read
    @signature = request.env['HTTP_X_LINE_SIGNATURE']
  end
end
