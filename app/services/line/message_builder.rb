module Line
  class MessageBuilder
    attr_accessor :conversation

    def initialize
       @conversation = {
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
    end

    def built_text
      {
        type: 'text',
        text: conversation[key][:reply].sample
      }
    end

    def built_sticker
      {
        type: 'sticker',
        packageId: '3',
        stickerId: Random.new.rand(210..235).to_s
      }
    end
  end
end