module Demoqa
  class ShoppingCartPage < PageBase
    def remove_all_items
      while cart_remove_buttons_count > 0
        next_cart_remove_button.when_present.click
      end
    end

    def next_cart_remove_button
      cart_table.buttons(text: 'Remove').first
    end

    def cart_remove_buttons_count
      return 0 unless cart_table.exists?
      cart_table.buttons(text: 'Remove').count
    end

    def cart_table
      browser.table(class: 'checkout_cart')
    end

    def cart_text
      browser.div(class: 'entry-content').text
    end
  end
end
