class Alexa
    include Responsible
    include Initializable

    attr_accessor :session_attributes, :response, :res
    attr_reader :app_id, :intent, :session_new
    
    def initialize(args={})
      @app_id = app_id
      @session_attributes = session_attributes
      @session_new = session_new
      @intent = parse_intent(args)
      @res = build_response(args)
    end

    def self.intention_selector(alexa=@alexa)
     send("#{alexa.intent}")
    end

    def statement(text)
      self.text(text)
      self.end_session(true)
      self
    end

    def question(text)
      self.text(text)
      self.end_session(false)
      self
    end

    def reprompt(text)
      if ssml?(text)
        @res[:response][:reprompt] = {outputSpeech: {type: "SSML", ssml: text}}
      else
        @res[:response][:reprompt] =  {outputSpeech: {type: "PlainText", text: text}}
      end
      self
    end

    def self.verify?(id)
      id == ENV['APP_ID']
    end

    private

    def end_session(boolean)
      self.res[:response][:shouldEndSession] = boolean
    end

    def text(text)
      if ssml?(text)
        @res[:response] = {outputSpeech: {type: "SSML", ssml: text}}
      else
        @res[:response] =  {outputSpeech: {type: "PlainText", text: text}}
      end
      self
    end
end
