class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,only:[:edit,:update]

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
      flash[:notice] = "successfully"
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
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to("/users/#{@user.id}")
    else
      render :edit
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("users/login")
  end

  def ensure_correct_user
    if @current_user.id !=  params[:id].to_i
     redirect_to("/books")
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following_user
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user
    @book = Book.new
    render 'show_follower'
  end

  def search
    @user_or_book = params[:option]
    @how_search = params[:choice]
    if @user_or_book == "1"
      @users = User.search(params[:search],@user_or_book,@how_search)
    else
      @books = Book.search(params[:search],@user_or_book,@how_search)
    end
  end


  private
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to("/users/2")
    end
  end

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

end

