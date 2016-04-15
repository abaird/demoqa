module Demoqa
  class PageBase
    def initialize(browser)
      @browser = browser
    end

    attr_reader :browser

    def title
      browser.title
    end

    def base_url
      'http://store.demoqa.com'
    end
  end
end
