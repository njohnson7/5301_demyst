# /app/models/post.rb

class Post
  def self.connection
    db_connection = SQLite3::Database.new('db/development.sqlite3')
    db_connection.results_as_hash = true
    db_connection
  end

  def self.find id
    post_hash = connection.execute('SELECT * FROM posts WHERE posts.id = ? LIMIT 1', id).first
    new post_hash
  end

  def self.all
    post_hashes = connection.execute 'SELECT * FROM posts'
    post_hashes.map { |post_hash| new post_hash }
  end

  attr_reader :id, :title, :body, :author, :created_at, :errors

  def initialize attributes = {}
    set_attributes attributes
  end

  def set_attributes attributes
    @id           = attributes['id'] if new_record?
    @title        = attributes['title']
    @body         = attributes['body']
    @author       = attributes['author']
    @created_at ||= attributes['created_at']
    @errors       = {}
  end

  def save
    return false unless valid?
    new_record? ? insert : update
    true
  end

  def insert
    insert_query = <<~SQL
      INSERT INTO posts (title, body, author, created_at)
      VALUES (?, ?, ?, ?)
    SQL
    connection.execute insert_query,
      title,
      body,
      author,
      Date.current.to_s
  end

  def update
    update_query = <<~SQL
      UPDATE posts
      SET title  = ?,
          body   = ?,
          author = ?
      WHERE posts.id = ?
    SQL
    connection.execute update_query,
      title,
      body,
      author,
      id
  end

  def destroy
    connection.execute 'DELETE FROM posts WHERE posts.id = ?', id
  end

  def connection
    self.class.connection
  end

  def new_record?
    id.nil?
  end

  def valid?
    @errors['title']  = "can't be blank" if title.blank?
    @errors['body']   = "can't be blank" if body.blank?
    @errors['author'] = "can't be blank" if author.blank?
    @errors.empty?
  end
end
