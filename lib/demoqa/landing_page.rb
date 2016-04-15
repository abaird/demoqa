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

    def my_account_link
      browser.div(id: 'account').link
    end

    def goto_my_account_page
      my_account_link.click
    end
  end
end
