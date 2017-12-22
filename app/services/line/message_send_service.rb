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

    def built_hi_messages
      messages = [built_text(response_module: 'hi', response_type: 'reply')]

      messages << built_sticker
      messages
    end

    def built_hello_messages
      messages = [built_text(response_module: 'hello', response_type: 'reply')]

      messages << built_sticker
      messages
    end

    def built_travel_messages
      messages = [built_text(response_module: 'travel', response_type: 'reply')]

      messages << built_text(response_module: 'travel', response_type: 'command')
      messages << built_carousel(RedPlanet::AllHotelService.new.call!)
      messages
    end

    def built_go_messages
      messages = []

      response_data = RedPlanet::AllHotelService.new.call!
      locations = response_data.each.map do |item|
        {
          name: item['name'].downcase,
          hotels: item['children']
        }
      end

      is_found = false
      locations.each do |location|
        next if @phrase.match(/\b#{location[:name]}\b/i).blank?
        is_found = true

        messages << built_text(response_module: 'go', response_type: 'reply_ok')
        messages << built_text(response_module: 'go', response_type: 'command')

        messages << built_another_carousel(location[:hotels])
      end

      unless is_found
        messages << built_text(response_module: 'go', response_type: 'reply_not_found')

        messages << built_text(response_module: 'travel', response_type: 'command')
        messages << built_carousel(response_data)
      end

      messages
    end
  end
end
