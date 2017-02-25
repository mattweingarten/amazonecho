class AmazonEcho::Responsible
  def self.ssml?(text)
   text.include?('<speak>') ? true : false
  end

 def self.slots_passer(alexa)
   slots = alexa.slots
   case slots.length
   when 0
     send("#{alexa.intent}", alexa)
   when 1
     send("#{alexa.intent}", alexa, slots[0])
   when 2
     send("#{alexa.intent}", alexa, slots[0], slots[1])
   when 3
     send("#{alexa.intent}", alexa, slots[0], slots[1], slots[2])
   when 4
     send("#{alexa.intent}", alexa, slots[0], slots[1], slots[2], slots[3])
   when 5
     send("#{alexa.intent}", alexa, slots[0], slots[1], slots[2], slots[3], slots[4])
   when 6
     send("#{alexa.intent}", alexa, slots[0], slots[1], slots[2], slots[3], slots[4], slots[5])
   when 7
     send("#{alexa.intent}", alexa, slots[0], slots[1], slots[2], slots[3], slots[4], slots[5], slots[6])
   when 8
     send("#{alexa.intent}", alexa, slots[0], slots[1], slots[2], slots[3], slots[4], slots[5], slots[6], slots[7])
   when 9
     send("#{alexa.intent}", alexa, slots[0], slots[1], slots[2], slots[3], slots[4], slots[5], slots[6], slots[7], slots[8])
   when 10
     send("#{alexa.intent}", alexa, slots[0], slots[1], slots[2], slots[3], slots[4], slots[5], slots[6], slots[7], slots[8], slots[9])
   end
 end
end
