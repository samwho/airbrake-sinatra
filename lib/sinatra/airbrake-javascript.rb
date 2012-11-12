require 'sinatra/base'
require 'logger'

module Sinatra
  module AirbrakeJavascript
    def airbrake_javascript_sinatra options = {}
      abconfig = Airbrake.configuration rescue nil

      if abconfig.nil?
        logger.debug "Could not load the Airbrake config. Is Airbrake loaded?"
        return
      end

      return unless abconfig.public?

      log   = options[:logger] || logger || Logger.new(STDOUT)
      views = options [:views] || File.join(File.dirname(__FILE__), '..', 'templates')
      host  = options[:host] || Airbrake.configuration.host.dup
      port  = options[:port] || Airbrake.configuration.port
      host << ":#{port}" unless [80, 443].include?(port)

      js_api_key = (options[:js_api_key] || abconfig.js_api_key) rescue nil
      api_key    = (options[:api_key] || abconfig.api_key)
      url        = (options[:url] || request.url) rescue nil

      if js_api_key.nil?
        logger.debug "Could not find a js_api_key in options or the Airbrake config."
      end

      if api_key.nil?
        logger.debug "Could not find an api_key in options or the Airbrake config."
      end

      unless respond_to? :request
        logger.debug "No request object found in the current scope."
      end

      options = {
        :views         => views,
        :layout        => false,
        :use_full_path => false,
        :locals        => {
          :host        => host,
          :api_key     => api_key,
          :js_api_key  => js_api_key,
          :environment => options[:environment] || ENV['RACK_ENV'],
          :url         => url
        }
      }

      erb :airbrake_javascript_sinatra, options
    end

    def escape_javascript(html_content)
      return '' unless html_content
      javascript_mapping = { '\\' => '\\\\', '</' => '<\/', "\r\n" => '\n', "\n" => '\n' }
      javascript_mapping.merge("\r" => '\n', '"' => '\\"', "'" => "\\'")
      escaped_string = html_content.gsub(/(\\|<\/|\r\n|[\n\r"'])/) { javascript_mapping[$1] }
      "\"#{escaped_string}\""
    end
  end

  helpers AirbrakeJavascript
end
