#Amazon Echo Skills gem 

##Summary

This gem was created to make it easy for anyone to make an alexa skill using Ruby on Rails, for faster deployment.
Focus on simplicity and fast deployment. Check out [amazons documentation](https://developer.amazon.com/documentation/menu.html) for full  understanding.
Follow the tutorial below to use it. Enjoy!
____


##Tutorial

###Overview 

This gem handles the alexa amazon request for their server and allows the user to manipulate alexa to create new skills.
Basically it has an AmazonEcho class on which you can all the methods below. After using the methods the server will respond
to Amazons servers in JSON

###Methods
The following methods are all instance methods for the class AmazonEcho


 - `alexa.question(string)`<br /><br />
 Determines alexas speech response, unlike the statement method it keeps the alexa session open.
 One can input 
 [SSML](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/speech-synthesis-markup-language-ssml-reference) 
 or just a normal string in this case 

- `alexa.statement(string)`<br /><br />
Same as question determines alexas speech response, however ends the alexa session afterwards.
Can input 
 [SSML](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/speech-synthesis-markup-language-ssml-reference) 
and a string

- `alexa.reprompt(string)`<br /><br />
Sets a reprompt speech for alexa, works only after a question speech and gets called 5 seconds after the question 
is stated and alexa has not received a voice response from the alexa user.    
Again can take a standard string or [SSML](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/speech-synthesis-markup-language-ssml-reference)

- `alexa.card(type, args)`<br /><br />
The card method sets value for the card to show on the mobile app alexa. The type input is a string, either **"Simple"**
**"Standard"** or **"LinkedAccount"**. The args is a hash with the following key options: **title**, **content**, **text**, **small_img** and **large_img**. 
For more details look at the [alexa docs](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/alexa-skills-kit-interface-reference)


- `alexa.session_attributes[key] = value`
Set alexa session value like this to use the variables over multiple intents and can be used throughout a whole alexa session.\
Make sure to do this before you call the question method.
______

##Setup 
First add `gem 'amazonecho'` to your gemfile then 
to setup up the server create a new rails app, generate a controller: <br>
`class IntentController < ApplicationController` <br>
and copy the following code into it. Also it requires a already setup [Intent schema](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/alexa-skills-kit-interaction-model-reference) and [ngrok proxy](https://ngrok.com/) to your localhost.

```ruby
class IntentController < ApplicationController
  skip_before_action  :verify_authenticity_token

  def intents
    respond_to do |format|
      format.json {
        render json: AlexaResponder.responds_to_alexa_requests(params)
      }
    end
  end
end
````

Make sure to update the routes.rb aswell:

```ruby
Rails.application.routes.draw do
  root to: 'intent#intents'
  post '/intents', to: 'intent#intents'
end
```


After that you can just write methods for each Intent, so lets say we have the "ExampleIntent" in our Intentschema, 
we can write a a method called example in our controller<br>
```ruby
def example(alexa)
  #write your code here
end 
```
Make sure to pass in the instance as the first argument(the name does not matter but it will be the instance you can call all 
the methods from above on). Make sure to add the name of your method to helper nethods as so:

```ruby
class IntentController < ApplicationController
  skip_before_action  :verify_authenticity_token

  helper_method  :example

```

####An example:

```ruby
 def example(alexa)
  alexa.session_attributes[:name] = "bob"
  alexa.session_attributes[:number] = 1
  alexa.question("hello").card("Standard", {title: "Yooo!", text: "Why me?", content: "How you doin?", larg_img: "http://example_url.com"})
end
```


To access **slot variables** passed in through voice commands to alexa, add them as arguments. Again names do not matter.

```ruby
def example(alexa, slot1, slot2, slot3)
  if slot1 == slot2
    alexa.statement("True")
  else 
    alexa.statement("False")
end
```
**Important:** Sometimes the slots are not in the same order as your Intent schema slots because of the way amazon sends the request, doublecheck if the 
slots contain the information you want or switch the ordering.(Working on a solution)





