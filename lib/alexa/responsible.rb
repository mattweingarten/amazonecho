class Alexa::Responsible
  def self.ssml?(text)
   text.include?('<speak>') ? true : false
  end
end
