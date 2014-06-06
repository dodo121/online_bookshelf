class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :get_book, :delete_cover]
  before_action :admin? , only: [:new, :edit, :show, :create, :update, :destroy, :delete_cover]
  # GET /books
  def index
    @books = Book.all
  end

  # GET /books/1
  def show
  end
  #help page
  def help
  end
  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books

  def create
    @book = Book.new(book_params)
      if @book.save
        redirect_to @book, notice: 'Book was successfully created.'
      else
        render action: 'new'
      end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
        redirect_to @book, notice: 'Book was successfully updated.'
      else
        render action: 'edit' 
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url 
  end

  def delete_cover
    @book.cover = nil
    @book.save
    flash[:notice] = "Cover destroyed!"
    redirect_to edit_book_path
  end

  def get_book
    current_user.books << @book
    flash[:notice] = "Book added to your bookshelf!"
    redirect_to root_path
  end
  
  def my_books
    @user_books = current_user.books.all
  end

  def delete_my_book
    @book = current_user.books.find(params[:id])
      if current_user.books.delete(@book)
         flash[:notice] = "Book deleted from your bookshelf!"
      redirect_to my_books_path
    end
  end
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :author, :cover)
    end

    def admin?
      if user_signed_in? && current_user.admin == true
        else
          redirect_to root_path
      end
    end
end
