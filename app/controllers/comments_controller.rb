class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = movie.comments.build(comment_params)

    if @comment.save
      redirect_to movie_path(movie), notice: "Comment was successfully created."
    else
      puts @comment.errors.inspect
      redirect_to movie_path(movie), flash: { errors: @comment.errors.full_messages }
    end
  end

  def destroy
    comment = movie.comments.find(params[:id])
    if comment.user == current_user
      comment.destroy
      flash[:notice] = "Comment was successfully destroyed."
    else
      flash[:error] = "You cannot remove not your comments."
    end

    redirect_to movie_path(movie)
  end

  private

  def movie
    @movie ||= Movie.find(params[:movie_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user: current_user, movie: movie)
  end
end
