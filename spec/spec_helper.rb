require_relative '../load_lib'
require 'demoqa'

require 'rspec'

RSpec.configure do |_config|
  def browser_driver
    ENV['DRIVER'].to_sym || :chrome
  end
end
