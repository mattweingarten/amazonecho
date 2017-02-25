class AlexaResponder
  def self.alexa_params(params)
    params.permit!
  end

  def self.responds_to_alexa_requests(params)
        alexa = AmazonEcho.new(AlexaResponder.alexa_params(params))
        AmazonEcho.intention_selector(alexa)
        puts "\n\n\n\n"
        pp alexa.res
        puts "\n\n\n\n"
        alexa.res
  end
end


require 'pp'
