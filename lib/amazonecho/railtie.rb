require 'amazonecho'
require 'rails'
class AmazonEcho
  class Railtie < Rails::Railtie
    rake_tasks do
      directory "app"
      directory "app/controllers"
      directory "config"


      task :amazonecho do
        Rake::Task["intent_controller.rb"].invoke
        Rake::Task["routes.rb"].invoke
        puts "\n\nReady to build alexa skills!\n\n"
      end




      file "intent_controller.rb" => "app/controllers" do

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


        sh " echo '#{string}' > 'app/controllers/intent_controller.rb'"
      end





      file "routes.rb" => "app/controllers" do

        string2 = """
Rails.application.routes.draw do

  root to: 'intent#intents'
  post '/intents', to: 'intent#intents'

end"""

        sh %Q! echo "#{string2}" > 'config/routes.rb'!
      end
    end
  end
end
