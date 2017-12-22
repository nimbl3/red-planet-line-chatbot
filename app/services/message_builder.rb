class MessageBuilder
  def built_sticker
    {
      type: 'sticker',
      packageId: '3',
      stickerId: Random.new.rand(210..235).to_s
    }
  end
end