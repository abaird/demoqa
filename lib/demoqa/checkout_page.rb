module Demoqa
  class QuantityWidget < PageBase
    def continue_button
      browser.link(class: 'step2')
    end

    def continue
      continue_button.click
    end
  end

  class ShippingInfoWidget < PageBase
    def popuplate_shipping_info(model)
      email_field.value = model.email
      # this isn't visible unless it comes last
      shipping_location_field.select model.country
      calculate_button.click
      first_name_field.value = model.first_name
      last_name_field.value = model.last_name
      address_field.value = model.address
      city_field.value = model.city
      state_select.value = model.state
      country_select.select model.country
      postal_code_field.value = model.postal_code
      phone_field.value = model.phone
      same_as_billing_address_checkbox.when_present.set
    end

    def billing_details_table
      browser.table(class: 'table-1')
    end

    def shipping_location_field
      Watir::Wait.until { browser.select_list(id: 'current_country').exists? }
      browser.select_list(id: 'current_country')
    end

    def calculate_button
      browser.button(name: 'wpsc_submit_zipcode')
    end

    def email_field
      label = browser.label(text: 'Enter your email address').when_present.for
      browser.text_field(id: label)
    end

    def label_helper(text, type)
      label = billing_details_table.label(text: text).when_present.for
      if type == :field
        billing_details_table.text_field(id: label)
      else
        billing_details_table.select_list(id: label)
      end
    end

    def first_name_field
      label_helper('First Name *', :field)
    end

    def last_name_field
      label_helper('Last Name *', :field)
    end

    def address_field
      label_helper('Address *', :field)
    end

    def city_field
      label_helper('City *', :field)
    end

    def state_select
      label_helper('undefined*', :field)
    end

    def country_select
      label_helper('Country *', :select)
    end

    def postal_code_field
      label_helper('Postal Code', :field)
    end

    def phone_field
      label_helper('Phone *', :field)
    end

    def purchase_button
      browser.button(name: 'submit', class: 'make_purchase')
    end

    def same_as_billing_address_checkbox
      browser.checkbox(id: 'shippingSameBilling')
    end

    def shipping_cost
      browser.table(class: 'table-4').row(class: 'total_shipping')[1].text.delete('$').to_f
    end
  end

  class PostPurchaseWidget < PageBase
    def results_div
      browser.div(class: 'wpsc-transaction-results-wrap')
    end

    def title
      browser.h1(class: 'entry-title')
    end

    def page_loaded?
      title.present? && results_div.present?
    end
  end

  class CheckoutPage < PageBase
    def page_loaded?
      browser.h1(class: 'entry-title').present?
    end

    alias loaded? page_loaded?

    def purchase_item(user_model)
      quantity = QuantityWidget.new(browser)
      quantity.continue
      shipping = ShippingInfoWidget.new(browser)
      shipping.popuplate_shipping_info(user_model)
      user_model.shipping_cost = shipping.shipping_cost
      shipping.purchase_button.click
      post_purchase = PostPurchaseWidget.new(browser)
      Watir::Wait.until(30) { post_purchase.page_loaded? }
      user_model
    end

    def total_cost
      text = browser.div(class: 'wpsc-transaction-results-wrap').p(index: -1).text
      text.split(':').last.delete('$').to_f
    end
  end
end
