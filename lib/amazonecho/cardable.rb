class AmazonEcho::Cardable
  attr_accessor :type, :title, :content, :text, :small_img, :large_img
  def initialize(type,  args={})
    case type
    when "Standard"
      @type = "Standard"
      @title = args.fetch(:title, nil)
      @content = args.fetch(:content, nil)
      @text = args.fetch(:text, nil)
    when "Simple"
      @type = "Simple"
      @title = args.fetch(:title, nil)
    when "LinkAccount"
      @type = "LinkAccount"
    end
    @small_img = args.fetch(:small_img, nil)
    @large_img = args.fetch(:large_img, nil)
  end

  def build_response
    card = {type: self.type}
    case self.type
    when "Simple"
      unless self.title == nil then card[:title] = self.title end
      unless self.content == nil then card[:content] = self.content end
      unless self.text == nil then card[:text] = self.text end
    when "Standard"
      unless self.title == nil then card[:title] = self.title end
    when "LinkAccount"
    end
    unless self.small_img == nil  && self.large_img == nil then card[:image] = {} end
    unless self.small_img == nil then card[:image][:smallImgUrl] = self.small_img end
    unless self.large_img == nil then card[:image][:largeImageUrl] = self.large_img end
    card
  end
end
