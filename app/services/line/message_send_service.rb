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
        when Line::Bot::Event::Beacon
          case event['beacon']['type']
          when 'enter'
            client.reply_message(event['replyToken'], built_welcome_messages(true))
          when 'leave'
            client.reply_message(event['replyToken'], built_bye_messages)
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

    def built_welcome_messages(isBeacon = false)
      messages = [built_text(response_module: 'welcome', response_type:'reply')]

      messages << built_sticker(247)

      messages += built_promotion_messages if isBeacon
      messages
    end

    def built_bye_messages
      messages = [built_text(response_module: 'bye', response_type:'reply')]

      messages << built_sticker(252)
      messages
    end

    def built_hi_messages
      built_greeting_messages
    end

    def built_hello_messages
      built_greeting_messages
    end

    def built_greeting_messages
      messages = [built_text(response_module: 'hi', response_type:'reply')]

      messages << built_sticker([240, 241, 242, 243, 256].sample)
      messages
    end

    def built_travel_messages
      messages = [built_text(response_module: 'travel', response_type: 'reply')]

      messages << built_text(response_module: 'travel', response_type: 'command')
      messages << built_location_carousel(RedPlanet::AllHotelService.new.call!)
      messages
    end

    def built_go_messages
      messages = [built_text(response_module: 'go', response_type: 'reply')]

      messages << built_sticker([220, 221, 222, 223, 224, 228, 229, 232, 233, 255].sample)
      messages
    end

    def built_promotions_messages
      built_promotion_messages
    end

    def built_promotion_messages
      messages = [built_text(response_module: 'promotion', response_type: 'reply')]

      messages << built_promotion_carousel(RedPlanet::AllPromotionService.new.call!)
      messages
    end
  end
end
