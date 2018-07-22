class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post    = Post.find params['id']
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new('author' => params['author'], 'title' => params['title'], 'body' => params['body'])
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find params['id']
  end

  def update
    @post = Post.find params['id']
    @post.set_attributes('author' => params['author'],
                         'title'  => params['title'],
                         'body'   => params['body'])
    if @post.save
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    post = Post.find params['id']
    post.destroy
    redirect_to posts_path
  end
end

