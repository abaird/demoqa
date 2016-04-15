describe 'demoqa' do
  before(:each) do
    @browser = Watir::Browser.new browser_driver
    landing_page.visit
  end

  after(:each) do
    @browser.close unless @browser.nil?
  end

  let(:landing_page) { Demoqa::LandingPage.new(@browser) }
  let(:product_list_page) { Demoqa::ProductListPage.new(@browser) }
  let(:shopping_cart_page) { Demoqa::ShoppingCartPage.new(@browser) }

  it 'should remove items from the cart' do
    landing_page.navigate_to('iPhones')
    product_list_page.add_all_to_cart
    product_list_page.view_cart
    shopping_cart_page.remove_all_items
    expect(shopping_cart_page.cart_text).to eq 'Oops, there is nothing in your cart.'
  end
end
