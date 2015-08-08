$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'appt/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'appt'
  s.version     = Appt::VERSION
  s.authors     = ['Paul Tyng']
  s.email       = ['paul@paultyng.net']
  s.homepage    = 'https://github.com/paultyng/appt'
  s.summary     = 'appt engine'
  s.description = ''
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile',
    'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 4.1', '< 4.3'
  s.add_dependency 'bootstrap-sass', '~> 3.3', '>= 3.3.4'
  s.add_dependency 'sass', '~> 3.1'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'jquery-rails', '~> 3.1'
  s.add_dependency 'haml-rails', '~> 0.9'
  s.add_dependency 'bootstrap_form', '~> 2.3'
  s.add_dependency 'kaminari', '~> 0.15'
  s.add_dependency 'rails_bootstrap_navbar', '~> 2.0'
  s.add_dependency 'bootstrap-navbar', '~> 2.2'

  s.add_dependency 'activemodel-associations', '~> 0.1'
  s.add_dependency 'phony', '~> 2.14'
  s.add_dependency 'phony_rails', '~> 0.12'

  s.add_dependency 'tod', '~> 2.0'
  s.add_dependency 'workhours', '~> 0.2'
  s.add_dependency 'simple_calendar', '~> 1.1'
  s.add_dependency 'icalendar', '~> 2.3'

  s.add_development_dependency 'pg'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'therubyracer'
end

