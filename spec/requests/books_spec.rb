require 'spec_helper'
require 'rack/test'

describe "Books" do
	subject { page }
   
    describe "page for user should have right features" do
        before { visit root_path }
        it { should_not have_link('Edit', href: edit_book_path(@book)) }
        it { should_not have_link('Destroy')}
        it { should_not have_link('New Book', href: new_book_path) }
        it { should have_content('List of all the books')}
        it { should have_link('Show') }
        it { should have_link('Get this book')}
    end
end
