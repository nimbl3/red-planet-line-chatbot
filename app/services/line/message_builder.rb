module Line
  class MessageBuilder
    attr_accessor :conversation

    def initialize
      @conversation = {
        hi: {
          reply: [
            'Hello!, what can I do for you?',
            'Hi! :)',
            'Hey, how\'s it going?'
          ]
        },
        hello: {
          reply: [
            'Hello!, what can I do for you?',
            'Hi! :)',
            'Hey, how\'s it going?'
          ]
        },
        travel: {
          reply: [
            'So exciting!!! Where would you like to go?',
            'Where would you like to go?',
            'What\'s your favorite place go?',
            'Just tell me :)'
          ],
          command: [
            '---- select below ----'
          ],
          end_point: [
            '/hotel_location'
          ]
        },
        go: {
          # reply: [
          #   'Look!! That\'s such a nice place!!!',
          #   'Come on!! Let\'s make it happen today :)',
          #   'This is the best hotel *EVER* :)'
          # ],
          reply_ok: [
            'These are all hotels we have :)',
            'Which hotel that you want to see more detail?',
            'Let\'s pick one!!!',
            'All in my hands ~'
          ],
          reply_not_found: [
            'We don\'t have any hotels in this location :\')',
            'We have nothing ~',
            'Sorry bro!!'
          ],
          command: [
            '---- select below ----'
          ],
          end_point: [
            '/hotel_location'
          ]
        }
      }.freeze
    end

    def built_text(response_module:, response_type:)
      {
        type: 'text',
        text: conversation[response_module.to_sym][response_type.to_sym].sample
      }
    end

    def built_sticker
      {
        type: 'sticker',
        packageId: '3',
        stickerId: Random.new.rand(210..235).to_s
      }
    end

    def built_carousel(items)
      {
        type: 'template',
        altText: 'This is a image carousel template',
        template: {
          type: 'image_carousel',
          columns: items.each.map do |item|
            {
              imageUrl: item['image_path'],
              action: {
                type: 'message',
                label: item['display_name'],
                text: "I want to go to #{item['name']}"
              }
            }
          end
        }
      }
    end

    def built_another_carousel(items)
      {
        "type": "template",
        "altText": "this is a carousel template",
        "template": {
          "type": "carousel",
          "columns": [
            {
              "thumbnailImageUrl": "https://placeit.net/uploads/stage/stage_image/659/default_IMG_5790_base.jpg",
              "imageBackgroundColor": "#000000",
              "title": "this is menu",
              "text": "description",
              "actions": [
                {
                  "type": "uri",
                  "label": "View detail",
                  "uri": "https://preview.redplanethotels.com/search"
                }
              ]
            },
            {
              "thumbnailImageUrl": "https://placeit.net/uploads/stage/stage_image/659/default_IMG_5790_base.jpg",
              "imageBackgroundColor": "#000000",
              "title": "this is menu",
              "text": "description",
              "actions": [
                {
                  "type": "uri",
                  "label": "View detail",
                  "uri": "https://preview.redplanethotels.com/search"
                }
              ]
            }
          ],
          "imageAspectRatio": "rectangle",
          "imageSize": "cover"
        }
      }
      # p items
      #
      # {
      #   type: 'template',
      #   altText: 'this is a carousel template',
      #   template: {
      #     type: 'carousel',
      #     imageAspectRatio: 'rectangle',
      #     imageSize: 'cover',
      #     columns: items.each.map do |item|
      #       {
      #         thumbnailImageUrl: item['image_path'],
      #         imageBackgroundColor: '#000000',
      #         title: item['display_name'],
      #         action: [
      #           {
      #             type: 'uri',
      #             label: 'Buy',
      #             data: 'https://preview.redplanethotels.com/search'
      #           },
      #           {
      #             type: 'uri',
      #             label: 'View detail',
      #             uri: 'https://preview.redplanethotels.com/search'
      #           }
      #         ]
      #       }
      #     end
      #   }
      # }

      # {
      #   type: 'template',
      #   altText: 'this is a carousel template',
      #   template: {
      #     type: 'carousel',
      #     columns: [
      #       {
      #         "thumbnailImageUrl": 'https://placeit.net/uploads/stage/stage_image/659/default_IMG_5790_base.jpg',
      #         "imageBackgroundColor": '#000000',
      #         "title": 'this is menu',
      #         "text": 'description',
      #         "actions": [
      #           {
      #             "type": 'uri',
      #             "label": 'Buy',
      #             "data": 'https://preview.redplanethotels.com'
      #           },
      #           {
      #             "type": 'uri',
      #             "label": 'View detail',
      #             "uri": 'https://preview.redplanethotels.com'
      #           }
      #         ]
      #       }
      #     ],
      #     imageAspectRatio: 'rectangle',
      #     imageSize: 'cover'
      #   }
      # }
    end
  end
end
