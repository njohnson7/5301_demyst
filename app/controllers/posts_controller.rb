# /app/controllers/posts_controller.rb

class PostsController < ApplicationController

  # list_posts -> list -> index
  def index
    @posts = Post.all
  end

  # show_post -> show
  def show
    @post    = Post.find(params['id'])
    @comment = Comment.new
  end

  # new_post -> new
  def new
    @post = Post.new
  end

  # create_post -> create
  def create
    @post = Post.new('author' => params['author'], 'title' => params['title'], 'body' => params['body'])
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  # edit_post -> edit
  def edit
    @post = Post.find(params['id'])
  end

  # update_post -> update
  def update
    @post = Post.find(params['id'])
    @post.set_attributes('author' => params['author'],
                         'title' => params['title'],
                         'body' => params['body'])
    if @post.save
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  # delete_post -> delete -> destroy
  def destroy
    post = Post.find(params['id'])
    post.destroy
    redirect_to posts_path
  end
end
