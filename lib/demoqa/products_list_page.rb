module Demoqa
  class ProductListPage < PageBase
    def page_loaded?
      browser.div(id: 'default_products_page_container').visible?
    end
    alias loaded? page_loaded?

    def content
      browser.div(id: 'content')
    end

    def go_to_checkout
      browser.div(id: 'fancy_notification_content').link(class: 'go_to_checkout')
    end

    def product_container(title)
      content.h2s.find { |x| x.text == title }.parent
    end

    def price_of(title)
      product_container(title).span(class: 'currentprice').text.delete('$').to_f
    end

    def add_to_cart(title)
      product_container(title).button(name: 'Buy').click
      go_to_checkout.when_present.click
    end
  end
end
