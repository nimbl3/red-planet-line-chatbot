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

          message = built_messages
          client.reply_message(event['replyToken'], message)
        end
      end
    end

    render status: 200, json: { message: 'OK' }
  end

  private

  def built_messages
    CONVERSATIONS.keys.each do |key|
      if @phrase.match(/\b#{key.to_s}\b/i).present?
        return send("built_#{key}_messages")
      end
    end

    {
      type: 'text',
      text: 'T_T'
    }
  end

  def built_travel_messages
    messages = [{
      type: 'text',
      text: CONVERSATIONS[:travel][:reply].sample
    }]

    messages << built_carousel_message(RedPlanet::AllHotelService.new.call!)
    messages
  end

  def built_go_messages
    messages = [{
      type: 'text',
      text: CONVERSATIONS[:go][:reply].sample
    }]

    # messages << built_marketing_message(RedPlanet::AllHotelService.new.call!)
    messages
  end

  def built_carousel_message(items)
    {
      type: 'template',
      template: {
        type: 'image_carousel',
        columns: items.each.map do |item|
          {
            imageUrl: item['image_path'],
            action: {
              type: 'message',
              label: item['display_name'],
              text: ['I\'d like to go to ', item['name']].join
            }
          }
        end
      }
    }
  end

  # def built_marketing_message(items)
  #   items.map {|item| item['name'] }.each do |place|
  #
  #   end
  # end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = LINE_CHANNEL_SECRET
      config.channel_token = LINE_CHANNEL_TOKEN
    end
  end
end
