class MessageSendService
  CONVERSATIONS = {
    travel: {
      reply: [
        'So exciting!!! Where would you like to go?',
        'Where would you like to go?',
        'What\'s your favorite place go?',
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
      end_point: %w[/hotel_location /hotel/location]
    }
  }.freeze

  def initialize(events:, client:)
    @events = events
    @client = client
  end

  def call!
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          @phrase = event.message['text']

          message = built_message
          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Sticker
          client.reply_message(event['replyToken'], built_sticker)
        else
          client.reply_message(event['replyToken'], built_sticker)
        end
      end
    end
  end

  private

  attr_reader :events, :client

  def built_sticker
    {
      type: 'sticker',
      packageId: '3',
      stickerId: Random.new.rand(210..235).to_s
    }
  end

  def built_message
    CONVERSATIONS.keys.each do |key|
      if @phrase.match(/\b#{key.to_s}\b/i).present?
        return {
          type: 'text',
          text: CONVERSATIONS[key][:reply].sample
        }
      end
    end

    built_sticker
  end
end