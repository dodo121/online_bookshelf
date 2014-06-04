class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :get_book]
  before_action :set_id, only: [:my_books, :delete_my_book]
  before_action :admin? , only: [:new, :edit, :show, :create, :update, :destroy]
  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end
  #about page
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
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
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
    def set_id
       @user_id = current_user.id
    end

    def admin?
      if user_signed_in? && current_user.admin == true
        else
          redirect_to root_path
      end
    end
end
