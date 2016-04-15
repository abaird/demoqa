module Demoqa
  class MyAccountPage < PageBase
    def username_field
      browser.text_field(id: 'log')
    end

    def password_field
      browser.text_field(id: 'pwd')
    end

    def login_button
      browser.button(id: 'login')
    end

    def login(username, password)
      Watir::Wait.until { username_field.present? && password_field.present? }
      username_field.value = username
      password_field.value = password
      login_button.click
      Watir::Wait.until { browser.h1(class: 'entry-title').present? }
    end

    def goto_details
      details_link.when_present.click
    end

    def details_link
      browser.div(class: 'myaccount').link(text: 'Your Details')
    end
  end
end
