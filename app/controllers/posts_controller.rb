# frozen_string_literal: true

class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params) do |post|
      post.user = current_user
    end
    if @post.save
      redirect_to posts_url
    else
      redirect_to root_path, notice: @post.errors.full_messages.first
    end
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_user
    redirect_to posts_url
  end

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_by current_user
    redirect_to posts_url
  end

  def edit
    set_post
    if not_curr_user?
      flash[:alert] = "Sorry! You can't edit someone else's post."
    elsif @post.not_editable?
      flash[:alert] = "10 minutes exceeded: you can no longer edit the post."

      redirect_to posts_url
    end
    return if @post

    redirect_to root_path
  end

  def update
    set_post

    if @post.update(message: params[:post][:message])
      flash[:notice] = 'Successfully updated the post!'
      redirect_to posts_url
    else
      flash[:alert] = 'Couldn’t edit the post...'
      render :edit
    end
  end

  def destroy
    set_post
    if not_curr_user?
      flash[:alert] = "Sorry! You can't delete someone else's post."
    elsif curr_user? && @post.can_destroy?
      flash[:notice] = 'Successfully deleted the post!'
    end
  end

  def index
    @posts = Post.all
  end

  private

  def set_post
    @post = Post.where(id: params[:id]).first
  end

  def post_params
    params.require(:post).permit(:message)
  end

  def curr_user?
    @post.user

    redirect_to posts_url
  end

  def not_curr_user?
    return unless current_user != @post.user

    redirect_to posts_url
  end

end
