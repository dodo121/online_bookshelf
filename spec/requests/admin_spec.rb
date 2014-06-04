require 'spec_helper'

describe "Admin" do

	subject { page }
	let(:admin){ FactoryGirl.create(:admin)}
	let(:book){ FactoryGirl.create(:book)}
	describe "after signin should have right features" do
		before do 
			visit new_user_session_path
			fill_in "Email", with: admin.email
			fill_in "Password", with: admin.password
			click_button "Sign in"
			visit root_path
		end
		describe "can add new book to list" do
			before do visit new_book_path
					fill_in "Name", with: book.name
					fill_in "Author", with: book.name
					click_button "Create Book"
					visit root_path
			end
			it { should have_content(book.name && book.author)}
			it { should have_link("Sign out", href:  destroy_user_session_path) }
			it { should have_link('Edit', href: edit_book_path(book)) }
        	it { should have_link('Destroy') }
        	it { should have_link('Add new book', href: new_book_path) }
        	it { should have_link("Get this book", href: get_book_book_path(book)) }
		end
		describe "can visit page edit" do
			before { visit edit_book_path(book) }
			it { should have_content("Name" && "Author")}
			it { should have_button "Update Book"}
		
			describe "can visit show page after editing" do
				before do click_button "Update Book"
						current_path.should == book_path(book)
				end
				it { should have_content(book.name && book.author)}
			end
		end	
	end
end