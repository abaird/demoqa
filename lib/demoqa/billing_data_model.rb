module Demoqa
  Struct.new('BillingData',
             :first_name,
             :last_name,
             :address,
             :city,
             :state,
             :country,
             :postal_code,
             :phone,
             :email,
             :shipping_cost)
  def self.billing_data_model
    Struct::BillingData.new(
      'Mickey',
      'Mouse',
      '1 Magic Kingdom Way',
      'Orlando',
      'FL',
      'USA',
      '12345',
      '123-456-7890',
      'mickey@mouse.com',
      0
    )
  end
end
