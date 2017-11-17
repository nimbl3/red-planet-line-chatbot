class MessageController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :client

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']

    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
        when Line::Bot::Event::Message
          case event.type
            when Line::Bot::Event::MessageType::Text
              message = {
                type: 'text',
                text: event.message['text']
              }
              client.reply_message(event['replyToken'], message)
          end
      end
    end

    'OK'
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = LINE_CHANNEL_SECRET
      config.channel_token = LINE_CHANNEL_TOKEN
    end
  end
end
