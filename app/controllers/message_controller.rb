require 'line/bot'

class MessageController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :client, only: [:callback]

  CONVERSATIONS = {
    travel: {
      reply: [
        'So exciting!!! Where would you like to go?',
        'Where would you like to go?',
        'What\'s your favotite place go?',
        'Just tell me :)'
      ],
      end_point: [
        '/hotel_location'
      ]
    },
    go: {
      reply: [
        'Look!! That\'s such a nice place!!!',
        'Come on!! Let\'s make it happen today :)',
        'This is the best hotel *EVER* :)'
      ],
      end_point: [
        '/hotel_location',
        '/hotel/location'
      ]
    }
  }.freeze

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
              @phrase = event.message['text']

              message = lookup_conversation
              client.reply_message(event['replyToken'], message)
          end
      end
    end

    render status: 200, json: { message: 'OK' }
  end

  private

  def built_message
    {
      type: 'text',
      text: lookup_conversation
    }
  end

  def lookup_conversation
    CONVERSATIONS.keys.each do |key|
      if @phrase.match(/\b#{key.to_s}\b/i).present?
        return CONVERSATIONS[key][:reply].sample
      end
    end

    '(scream)'
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = LINE_CHANNEL_SECRET
      config.channel_token = LINE_CHANNEL_TOKEN
    end
  end
end
