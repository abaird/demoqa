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

    def continue_shopping
      browser.div(id: 'fancy_notification_content').link(class: 'continue_shopping')
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

    def add_all_to_cart
      browser.buttons(name: 'Buy').each do |button|
        button.when_present.click
        continue_shopping.when_present.click
        Watir::Wait.while { browser.div(class: 'popup').present? }
      end
    end

    def view_cart_link
      browser.div(id: 'header_cart').link
    end

    def view_cart
      view_cart_link.when_present.click
    end
  end
end
