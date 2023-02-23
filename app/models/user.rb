class User < ApplicationRecord
  has_many :likes
  has_many :comments
  has_many :posts

  def three_most_recent_posts
    posts.order('created_at Desc').limit(3)
  end
end
