class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find_by(id: params[:id])
  	@book = Book.find_by(id: params[:id])
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
     if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all.order(created_at: :desc)
      @user = current_user
      render :index
    end
  end


  def edit
  	@user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update!(user_params)
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("users/login")
  end
  private
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name,:image,:introduction)
  end

end

