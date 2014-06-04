FactoryGirl.define do
  factory :user do
  	email "jan@kowalski.pl"
  	password "janjanjan"
  	password_confirmation "janjanjan"
  end
  factory :admin, class: :"user" do
  	email "admin@kowalski.pl"
  	password "janjanjan"
  	password_confirmation "janjanjan"
  	admin :true
  end
end
