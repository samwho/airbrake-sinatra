# Airbrake::Sinatra

The helper method provided with the official Airbrake gem is specific to Rails
and requires a bit of hacking to get working in Sinatra. This gem exists to
serve as a Sinatra helper method for the Airbrake Javascript.

## Installation

Add this line to your application's Gemfile:

    gem 'airbrake-sinatra', :require => 'sinatra/airbrake-javascript'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install airbrake-sinatra

## Usage

There are two sample applications in the source code on Github. You will find
them under the `examples/` directory. One of them shows how to use this gem with
a standard Sinatra `server.rb` file. The other shows how to use this gem with
your own class that extends `Sinatra::Base`. There is a subtle difference :)

Essentially all it boils down to is using the `airbrake_javascript_sinatra`
helper in your views. An example layout might look something like this:

``` haml
%head
  = airbrake_javascript_sinatra
%body
  %p
    The Airbrake javascript helper is outputting the following into the header:
    %pre= h airbrake_javascript_sinatra
```

Note that if you do not use `Bundler.require` with the `gem` line specified in
the above section you will need to require the gem manually like so:

``` ruby
require 'sinatra/airbrake-javascript'
```

## Developing

There are two Rake tasks that are there for development purposes:

    $ rake example:one
    $ rake example:two

Both of these cd into the appropriate `example/` directory and execute the
`shotgun` command.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
