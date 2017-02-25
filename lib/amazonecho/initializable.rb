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
    attributes = args[:session][:attributes][:session]
    attributes == nil ? {} : attributes
  end

  def self.session_new(args)
    args[:session][:attributes]
  end

  def self.slots(args)
    slots = args[:request][:intent][:slots]
    slots == nil ? [] :
    slots.each_with_object([]) { | (key, value), arr| arr << value["value"]} 
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
