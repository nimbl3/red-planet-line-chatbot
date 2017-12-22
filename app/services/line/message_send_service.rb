module Line
  class MessageSendService < MessageBuilder
    def initialize(events:, client:)
      @events = events
      @client = client
      @conversation = MessageBuilder.new.conversation
    end

    def call!
      events.each do |event|
        case event
        when Line::Bot::Event::Message
          case event.type
          when Line::Bot::Event::MessageType::Text
            @phrase = event.message['text']

            message = built_conversation
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

    def built_conversation
      @conversation.keys.each do |key|
        if @phrase.match(/\b#{key.to_s}\b/i).present?
          return send("built_#{key}_messages")
        end
      end

      built_sticker
    end
  end

  def built_travel_messages
    messages = [built_text('travel')]

    messages << built_carousel_message(RedPlanet::AllHotelService.new.call!)
    messages
  end
end
