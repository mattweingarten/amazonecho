require 'amazonecho'
require 'rails'
class AmazonEcho
  class Railtie < Rails::Railtie
    rake_tasks do
      directory "app"
      directory "app/controllers"
      task :amazonecho do
        string =
'class IntentController < ApplicationController
     skip_before_action  :verify_authenticity_token
     #Don`t forget to add all the Intent methods as helpers and to update your routes!
     #helper_method: example
     def intents
       respond_to do |format|
         format.json {
           render json: AlexaResponder.responds_to_alexa_requests(params)
         }
       end
     end
end

# add your intent methods here like this:
# def example(alexa, slot1, slot2) etc...
  # code here
# end'

         file "build" => "app/controllers" do
           sh " echo '#{string}' > 'app/controllers/intent_controller.rb'"
        end
      end
        puts "Created file 'intent_controller'"
    end
  end
end
