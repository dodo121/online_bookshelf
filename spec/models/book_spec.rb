require 'spec_helper'

describe Book do
  
  before do
  	@book = Book.new(name:"Example name", author:"Example author", cover_file_name: "Makbet")
  end
  subject { @book }

  it { should respond_to(:name) }
  it { should respond_to(:author) }
  it { should have_attached_file(:cover) }
  it { should validate_attachment_presence(:cover) }
  it { should be_valid }

  describe "name presence in form" do
  	before do
  		@book = Book.new(name:"", author: "Example author")
  	end
  	it { should_not be_valid }
  end 
  describe "author presence in form" do
  	before do
  		@book = Book.new(name:"Example name", author: "")
  	end
  	it { should_not be_valid }
  end
  describe "cover not present" do
  	before do
    @book = Book.new(name:"Example name", author:"Example author", cover:"")
  end
  	it {should_not be_valid }
  end
end
