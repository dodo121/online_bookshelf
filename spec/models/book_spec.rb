require 'spec_helper'

describe Book do
  
  before do
  	@book = Book.new(name:"Example name", author:"Example author")
  end
  subject { @book }

  it { should respond_to(:name) }
  it { should respond_to(:author) }
 
  it { should be_valid }

  describe "name presence in form" do
  	before do
  		@book = Book.new(name:"", author: "Example author",cover_file_name: "Makbet")
  	end
  	it { should_not be_valid }
  end 
  describe "author presence in form" do
  	before do
  		@book = Book.new(name:"Example name", author: "",cover_file_name: "Makbet")
  	end
  	it { should_not be_valid }
  end
end
