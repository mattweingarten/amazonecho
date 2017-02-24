module Responsible
  def ssml?(text)
   text.include?('<speak>') ? true : false
  end


  def build_response(args)
  {
    version: args[:version],
    response: {
      shouldEndSession: nil
    }
  }
  end

end
