class BookCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		book = Book.find(params[:book_id])
		comment = current_user.book_comments.new(book_comment_params)
		comment.book_id = book.id
		comment.save
		redirect_to book_path(book)
	end

	def destroy
		@comment = Comment.find_by(id: params[:id])
	    @comment.destroy!
    end
	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
