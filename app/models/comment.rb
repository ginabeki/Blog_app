class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  # A method that updates the comments counter for a post.
  def update_post_comments_counter
    post.increment!(:comments_counter)
  end
end