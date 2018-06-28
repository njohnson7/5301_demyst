class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  def hello_world
    name = params['name'] || 'World'
    render 'application/hello_world', locals: { name: name }
  end

  def list_posts
    posts = connection.execute 'SELECT * FROM posts'
    render 'application/list_posts', locals: { posts: posts }
  end

  def show_post
    post = connection.execute('SELECT * FROM posts WHERE posts.id = ? LIMIT 1', params['id']).first
    render 'application/show_post', locals: { post: post }
  end

  def new_post
    render 'application/new_post'
  end

  def create_post
    insert_query = <<-SQL
      INSERT INTO posts (title, body, author, created_at)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_query,
      params['title'],
      params['body'],
      params['author'],
      Date.current.to_s

    redirect_to '/list_posts'
  end

  private

  def connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end
end
