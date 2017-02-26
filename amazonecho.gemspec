Gem::Specification.new do |s|
  s.name        = 'amazonecho'
  s.version     = '1.0.8'
  s.date        = '2017-02-24'
  s.summary     = "Creating Alexa skills made easy"
  s.description = "Creating Alexa skills made easy"
  s.authors     = ["Matt Weingarten"]
  s.email       = 'matt@weingarten.org'
  s.files       = ["lib/amazonecho.rb",
                   "lib/alexa_responder.rb",
                   "lib/amazonecho/initializable.rb",
                   "lib/amazonecho/responsible.rb",
                   "lib/amazonecho/cardable.rb",
                   "tasks/amazonecho.rake",
                   "lib/amazonecho/railtie.rb"
                    ]
  s.homepage    =
    'https://github.com/mattweingarten/amazonecho'
  s.license       = 'MIT'
end
