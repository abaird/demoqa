module Demoqa
  module MenuNav
    def main_nav
      browser.nav(id: 'main-nav')
    end

    def navigate_to(location)
      main_nav.links.select { |link| link.text == 'Product Category' }.first.hover
      main_nav.links.select { |link| link.text == location }.first.click
    end
  end
  class LandingPage < PageBase
    include MenuNav

    def visit
      browser.goto base_url
    end

    def page_loaded?
      main_nav.visible?
    end
    alias loaded? page_loaded?
  end
end
