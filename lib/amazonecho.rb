class AmazonEcho
    attr_accessor :session_attributes, :response, :res
    attr_reader :app_id, :intent, :session_new

    def initialize(args={})
      @app_id = Initializable.app_id(args)
      @session_attributes = Initializable.session_attributes(args)
      @session_new = Initializable.session_new(args)
      @intent = Initializable.parse_intent(args)
      @res = Initializable.build_response(args)
    end

    def self.intention_selector(alexa)
     send("#{alexa.intent}", alexa)
    end

    def self.verify?(id)
      id == ENV['APP_ID']
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
      if Responsible.ssml?(text)
        @res[:response][:reprompt] = {outputSpeech: {type: "SSML", ssml: text}}
      else
        @res[:response][:reprompt] =  {outputSpeech: {type: "PlainText", text: text}}
      end
      self
    end


    def card(type, args={})
      card = Cardable.new(type,args)
      @res[:response][:card] = card.build_response
    end

    # private

    def end_session(boolean)
      self.res[:response][:shouldEndSession] = boolean
    end

    def text(text)
      if Responsible.ssml?(text)
        @res[:response][:outputSpeech] = {type: "SSML", ssml: text}
      else
        @res[:response][:outputSpeech] =  {type: "PlainText", text: text}
      end
      self
    end
end

require 'amazonecho/initializable'
require 'amazonecho/responsible'
require 'amazonecho/cardable'
