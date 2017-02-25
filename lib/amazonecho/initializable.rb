class AmazonEcho::Initializable
  def self.parse_intent(args)
    output = args[:request][:intent][:name].downcase
    output.slice!("intent")
    output
  end


  def self.app_id(args)
    args[:session][:application][:applicationId]
  end

  def self.session_attributes(args)
    args[:session][:attributes][:session]
  end

  def self.session_new(args)
    args[:session][:attributes]
  end

  def self.build_response(args)
  {
    version: args[:version],
    sessionAttributes: {
      session:{}
    },
    response: {
      shouldEndSession: nil
    }
  }
  end
end
