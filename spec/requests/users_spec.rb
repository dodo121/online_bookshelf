require 'spec_helper'

describe "Signup/Signin" do

	subject { page }

	describe "correct Signup" do
		let(:user){ FactoryGirl.create(:user)}
		before do
			visit  new_user_registration_path
			fill_in "Email", with: user.email
			fill_in "Password", with: user.password
			fill_in "Password confirmation", with: user.password
			click_button "Sign up"
			current_path.should == root_path
		end
		it { should have_link("Sign out") }
		it { should have_link("My books") }
	
		describe "correct signin and view for signedin user" do
			before do
				visit new_user_session_path
				fill_in "Email", with: user.email
				fill_in "Password", with: user.password
				click_button "Sign in"
				current_path.should == root_path
			end
				it { should have_link("Sign out") }
				it { should have_link("My books") }

				describe "correct_signout" do
					before do
						click_link "Sign out!"
						current_path.should == root_path
					end
				it { should_not have_link("Sign out") }
				it { should_not have_link("My books") }
			end
		end
	end
end
