class BooksController < ApplicationController
  before_action :authenticate_user!

 def index
    @books = Book.all.order(created_at: :desc)
    @user = current_user
    @book = Book.new
  end
  
  def show
    @book = Book.find_by(id: params[:id])
    @user = current_user
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/books")
    else
      @books = Book.all.order(created_at: :desc)
      @user = current_user
      render :index
    end
  end
  def edit
    @book = Book.find_by(id: params[:id])
  end
  def update
    @book = Book.find_by(id: params[:id])
    if @book.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/books")
    else
      @books = Book.all.order(created_at: :desc)
      @user = current_user
      render :index
    end
  end

def destroy
    @book = Book.find_by(id: params[:id])
    @book.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/books")
  end

  private
def correct_user
  book = Book.find(params[:id])
    if current_user.id = book.user.user_id
     redirect_to root_path
    end
end

 def book_params
  params.require(:book).permit(:title,:body)
 end
end