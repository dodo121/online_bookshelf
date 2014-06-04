require 'spec_helper'

describe "Books" do
	subject { page }
    
    let(:book){ FactoryGirl.create(:book)}
    
    describe "main page for non signed_in user" do
        before { visit root_path }
        it { should_not have_link('Edit', href: edit_book_path(book)) }
        it { should_not have_link('Destroy')}
        it { should_not have_link('Add new Book', href: new_book_path) }
        it { should have_content('List of all the books')}
        it { should_not have_link('Get this book')}
    end
    describe "app safety for non signed_in user" do
        describe "in edit page" do
            before do visit edit_book_path(book)
                current_path.should == root_path
            end
        end
        describe "in show page" do
            before do visit book_path(book)
                current_path.should == root_path
            end
        end
        describe "in add new book" do
            before do visit new_book_path
                    current_path.should == root_path
            end
        end
    end
end
