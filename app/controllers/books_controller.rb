class BooksController < ApplicationController
  def new
    @book = Book.new
  end

# _info.htmlのform_withによって呼び出される
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      # books_path(@book.id)からusers_pathに変更。
      # →show画面はbook_path！
      # 投稿する画面によりエラーなったり投稿できたり
      flash[:notice] = "Successfully"
      redirect_to book_path(@book.id)
    else
      render :new
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    # showアクション内に@bookが重複してる
    @book = Book.new
    # 変数名をbookからbooksに変更。ビューもあわせてbooksに変更。
    @books = Book.find(params[:id])
    @user = User.find_by(id: @books.user_id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end
