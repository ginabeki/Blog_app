require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject do
    Comment.new(
      post: Post.new(
        author: User.new(
          name: 'Gina',
          photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
          bio: 'Software developer.',
          posts_counter: 0
        ),
        title: 'My Title',
        text: 'My first post',
        likes_counter: 0,
        comments_counter: 0
      ),
      author: User.new(name: 'Gina', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software developer.',
                       posts_counter: 0),
      text: 'New comment'
    )
  end

  before { subject.save }
end
