require 'spec_helper'

describe "User" do

	
	subject { page }
	
	let(:user){ FactoryGirl.create(:user)}
	let(:book){ FactoryGirl.create(:book)}
	before do
		visit new_book_path
		fill_in "Name", with: book.name
		fill_in "Author", with: book.author
		click_button("Create Book")
	end
	describe "after correct Signup" do
		before do
			visit  new_user_registration_path
			fill_in "Email", with: user.email
			fill_in "Password", with: user.password
			fill_in "Password confirmation", with: user.password
			click_button "Sign up"
			visit books_path
		end
		it { should have_link("Sign out", href:  destroy_user_session_path(user)) }
		it { should have_link("My books", href: my_books_path(book)) }
		it { should have_link("Get this book", href: book_get_book_path(user,book)) }

			describe "correct getting books" do
				before do 
						visit root_path
						click_link("Get this book")
						current_path.should == root_path
				end
				it { should have_link("Delete") }
					describe "correct deleting books" do
						before do 
							visit my_books_path
							click_link('Delete')
							current_path.should == my_books_path
						end
					end
			end
		end


		describe "after correct signin" do
			before do
				visit new_user_session_path
				fill_in "Email", with: user.email
				fill_in "Password", with: user.password
				click_button "Sign in"
				#current_path.should == root_path
				visit root_path
			end
				it { should have_link("Sign out",  href:  destroy_user_session_path(user)) }
				it { should have_link("My books", href: my_books_path(book)) }
				it { should have_link("Get this book", href: book_get_book_path(user,book)) }

			describe "correct_signout" do
					before do
						click_link "Sign out"
						current_path.should == root_path
					end
				it { should_not have_link("Sign out") }
				it { should_not have_link("My books") }
			end
		end
end
