describe 'demoqa' do
  before(:each) do
    @browser = Watir::Browser.new browser_driver
    landing_page.visit
  end

  after(:each) do
    @browser.close unless @browser.nil?
  end

  let(:landing_page) { Demoqa::LandingPage.new(@browser) }
  let(:my_account_page) { Demoqa::MyAccountPage.new(@browser) }
  let(:details_page) { Demoqa::DetailsPage.new(@browser) }
  let(:username) { ENV['USEREMAIL'] || 'abaird@bairdsnet.net' }
  let(:password) { ENV['PASSWORD'] }

  it 'should update login info' do
    random_zip = Random.rand(99_999)
    landing_page.goto_my_account_page
    my_account_page.login(username, password)
    my_account_page.goto_details
    details_page.update_zipcode random_zip
    details_page.logout
    my_account_page.login(username, password)
    my_account_page.goto_details
    expect(details_page.zipcode).to eq random_zip.to_s
    details_page.logout
  end
end
