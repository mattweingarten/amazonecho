class AmazonEcho
    attr_accessor :session_attributes, :response, :res
    attr_reader :app_id, :intent, :session_new, :slots

    def initialize(args={})
      @app_id = Initializable.app_id(args)
      @session_new = Initializable.session_new(args)
      @intent = Initializable.parse_intent(args)
      @slots = Initializable.slots(args)
      @res = Initializable.build_response(args)
      @session_attributes = Initializable.session_attributes(args)
    end


    def session
      self.session_attributes[:session]
    end

    def self.intention_selector(alexa)
     Responsible.slots_passer(alexa)
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
      self.set_session
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

    def set_session
      self.session_attributes.each do |key,value|
        @res[:sessionAttributes][:session][key] = value
      end
    end
end

require 'amazonecho/initializable'
require 'amazonecho/responsible'
require 'amazonecho/cardable'
require 'alexa_responder'
