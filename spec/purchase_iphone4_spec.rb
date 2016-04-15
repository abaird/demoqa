describe 'demoqa' do
  before(:each) do
    @browser = Watir::Browser.new browser_driver
    landing_page.visit
  end

  after(:each) do
    @browser.close unless @browser.nil?
  end

  let(:purchase_item) { 'Apple iPhone 4S 16GB SIM-Free – Black' }
  let(:landing_page) { Demoqa::LandingPage.new(@browser) }
  let(:product_list_page) { Demoqa::ProductListPage.new(@browser) }
  let(:checkout_page) { Demoqa::CheckoutPage.new(@browser) }
  let(:billing_data_model) { Demoqa.billing_data_model }

  it 'should purchase an iphone4 for $270' do
    landing_page.navigate_to('iPhones')
    price = product_list_page.price_of(purchase_item)
    product_list_page.add_to_cart(purchase_item)
    populated_model = checkout_page.purchase_item(billing_data_model)
    shipping_cost = populated_model.shipping_cost
    expect(price + shipping_cost).to eq checkout_page.total_cost
  end
end
