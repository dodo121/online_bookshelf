FactoryGirl.define do
	sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
  	email
  	password "janjanjan"
  	password_confirmation "janjanjan"
  end
end
