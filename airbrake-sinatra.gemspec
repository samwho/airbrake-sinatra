# -*- encoding: utf-8 -*-
require File.expand_path('../lib/airbrake-sinatra/version', __FILE__)

module AirbrakeSinatra
  # Hash of:
  #
  #   "gem-name" => "version"
  #
  # pairs. Set version to nil if you want the latest.
  DEPENDENCIES ||= {
    :app => {
      "haml"    => nil,
      "sinatra" => nil,
      "airbrake" => nil,
    },

    :dev => {
      "rake"    => nil,
      "shotgun" => nil,
    }
  }
end

Gem::Specification.new do |gem|
  gem.authors       = ["Sam Rose"]
  gem.email         = ["sam.rose@forward.co.uk"]
  gem.description   = %q{A view helper for Airbrake desgined for Sinatra.}
  gem.summary       = %q{The Airbrake view helper in the official "airbrake" gem is designed for Rails. This is a version that works out of the box with Sinatra.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "airbrake-sinatra"
  gem.require_paths = ["lib"]
  gem.version       = Airbrake::Sinatra::VERSION

  AirbrakeSinatra::DEPENDENCIES[:app].each do |k, v|
    gem.add_dependency(*([k, v].compact))
  end

  AirbrakeSinatra::DEPENDENCIES[:dev].each do |k, v|
    gem.add_development_dependency(*([k, v].compact))
  end
end
