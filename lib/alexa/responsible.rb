module Responsible
  def ssml?(text)
   text.include?('<speak>') ? true : false
  end
end
