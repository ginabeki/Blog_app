class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true, length: { maximum: 250 }
  after_save :update_post_comments_counter
  # A method that updates the comments counter for a post.

  private

  def update_post_comments_counter
    post.increment!(:comments_counter)
  end
end
