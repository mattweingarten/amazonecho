module Initializable
  def parse_intent(args)
    output = args[:request][:intent][:name].downcase
    output.slice!("intent")
    output
  end


  def app_id(args)
    args[:session][:application][:applicationId]
  end

  def session_attributes(args)
    args[:session][:attributes]
  end

  def session_new(args)
    args[:session][:attributes]
  end
end
