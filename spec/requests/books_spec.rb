require 'spec_helper'
require 'rack/test'

describe "Books" do
	subject { page }
    before do
    @book = Book.create(name:"Example name", author:"Example author", cover_file_name: "Makbet")
    end
	
    describe "page for user should have right features" do
        before { visit books_path }
        it { should_not have_link('Edit', href: edit_book_path(@book)) }
        it { should_not have_link('Destroy')}
        it { should_not have_link('New Book', href: new_book_path) }
        it { should have_content('List of all the books')}
        it { should have_link('Show') }
        it { should have_link('Get this book')}

        describe "show page too" do
            before do click_link 'Show'
            current_path.should == book_path(@book) 
            end
            it { should_not have_link('Edit', href: edit_book_path(@book)) }
        end
    end

    describe "page for admin with right features" do
        before { visit admin_path }
        it { should have_link('Edit', href: edit_book_path(@book)) }
        it { should have_link('Destroy')}
        it { should have_link('New Book', href: new_book_path) }
        it { should have_content('Admin page')}
        it { should have_link('Show') }

            describe "book update page" do
                before do click_link 'Edit'
                current_path.should == edit_book_path(@book) 
                end
                it { should have_content("Name") }
                it { should have_content("Author") }
                it { should have_content("Select book cover") }
                it { should have_button("Update Book") }
            end
    end
    describe "books add page" do
   	    before { visit new_book_path }

        describe "have vaild form action adding book" do
        it { should have_content("Add new book") }
        it { should have_content("Name") }
        it { should have_content("Author") }
        it { should have_content("Select book cover") }
        it { should have_button("Create Book") }

        end
    end
end
