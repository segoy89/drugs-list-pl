# frozen_string_literal: true

require 'bundler'
Bundler.require(:default, ENV.fetch('RACK_ENV', :development))

Dotenv.load(".env.#{ENV.fetch('RACK_ENV', :development)}") if %w[development test].include?(ENV.fetch('RACK_ENV'))

require_relative 'config/database.rb'

Dir[File.join(__dir__, 'app/**', '*.rb')].each { |file| require file }

class DrugsList < Roda
  plugin :error_handler do |e|
    # use 3rd party service to log errors
  end
end

require_relative 'routes/init'
