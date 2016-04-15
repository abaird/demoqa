require_relative '../load_lib'
require 'demoqa'

require 'rspec'

RSpec.configure do |_config|
  def browser_driver
    (ENV['DRIVER'] || :chrome)
  end
end
