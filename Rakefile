#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'fileutils'

include FileUtils

namespace :example do
  desc "Run the first sample Sinatra application."
  task :one do
    cd File.join(File.dirname(__FILE__), 'example', 'one')
    exec "shotgun"
  end

  desc "Run the second sample Sinatra application."
  task :two do
    cd File.join(File.dirname(__FILE__), 'example', 'two')
    exec "shotgun"
  end
end
