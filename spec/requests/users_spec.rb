require 'spec_helper'

describe "User" do

	subject { page }

	let(:user){ FactoryGirl.create(:user)}
	let(:book){ FactoryGirl.create(:book)}

	describe "after sing in" do
		before do
			visit new_user_session_path
			fill_in "Email", with: user.email
			fill_in "Password", with: user.password
			click_button "Sign in"
			current_path.should == root_path
		end
		it { should have_content('Signed in')}
		it { should have_link("Sign out",  href:  destroy_user_session_path) }
		it { should have_link("My books", href: my_books_path) }
		it { should have_content("Name" && "Author")}
		it { should_not have_link('Sign in', href: new_user_session_path)}

		describe "and after sign out" do
			before do
					visit root_path
					click_link 'Sign out'
					current_path.should == root_path
			end
			it { should have_content('Signed out')}
			it { should have_link("Sign in", href: new_user_session_path) }
			it { should have_link("Sign up", href: new_user_registration_path) }
			it { should_not have_link("Sign out",  href:  destroy_user_session_path) }
			it { should_not have_link("My books", href: my_books_path) }
		end
	end
	describe "can create account" do
		before do
			visit  new_user_registration_path
			fill_in "Email", with: "testjan@kowalski"
			fill_in "Password", with: "janjanjan"
			fill_in "Password confirmation", with: "janjanjan"
			click_button "Sign up"
		end
		it { should have_link("Sign in", href: new_user_session_path) }
		it { should have_link("Sign out", href:  destroy_user_session_path) }
		it { should have_link("My books", href: my_books_path) }
	end
end
