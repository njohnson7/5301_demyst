class Comment < ApplicationRecord
  belongs_to :post

  validates_presence_of :body, :author

  after_save :update_last_commented_on

  private

    def update_last_commented_on
      post.last_commented_on = created_at
    end
  
  # attr_reader :id, :body, :author, :post_id, :created_at
  

  # def initialize attributes = {}
  #   @id           = attributes['id'] if new_record?
  #   @body         = attributes['body']
  #   @author       = attributes['author']
  #   @post_id      = attributes['post_id']
  #   @created_at ||= attributes['created_at']
  #   @errors       = {}
  # end

  # def insert
  #   insert_comment_query = <<~SQL
  #     INSERT INTO comments (body, author, post_id, created_at)
  #     VALUES (?, ?, ?, ?)
  #   SQL
  #   connection.execute insert_comment_query,
  #     body,
  #     author,
  #     post_id,
  #     Date.current.to_s
  # end

  # def update
  # end

  # def valid?
  #   errors['body']   = "can't be blank" if body.blank?
  #   errors['author'] = "can't be blank" if author.blank?
  #   errors.empty?
  # end

  # def post
  #   Post.find post_id
  # end
end

