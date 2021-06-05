class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.page(params[:page]).reverse_order
    # @book = Book.find(params[:id])だとidにuser id？が入る
    # # 絞り込みたい
    # user_id = params[:user_id]
    # @books = Book.where("user_id = #{user_id}")
    # @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user.id)
    else
      render:edit
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

   private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def book_params
    params.require(:book).permit(:user_id)
  end
end