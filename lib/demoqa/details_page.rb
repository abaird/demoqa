module Demoqa
  class DetailsPage < PageBase
    def update_zipcode(zip)
      postal_code_field.value = zip
      submit_button.click
    end

    def submit_button
      browser.button(name: 'submit')
    end

    def zipcode
      Watir::Wait.until { postal_code_field != '' }
      postal_code_field.when_present.value
    end

    def postal_code_field
      label = browser.label(text: 'Postal Code').for
      browser.text_field(id: label)
    end

    def logout
      browser.div(id: 'account_logout').when_present.link.click
    end
  end
end
