require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(author: User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0), title: 'Hello', text: 'This is my first post', likes_counter: 0, comments_counter: 0) }

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'comments_counter must be a number' do
    subject.comments_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'likes_counter must be greater than zero' do
    subject.likes_counter = -2
    expect(subject).to_not be_valid
  end

  it 'five_most_recent_comments should return a right result' do
    subject.comments.create(text: 'First comment')
    subject.comments.create(text: 'Second comment')
    subject.comments.create(text: 'Third comment')
    subject.comments.create(text: 'Fourth comment')
    subject.comments.create(text: 'Fifth comment')
    subject.comments.create(text: 'Sixth comment')
    subject.comments.create(text: 'Seventh comment')
    expect(subject.five_most_recent_comments.count).to eq(5)
  end

  it 'update_post_user_counter should return a right result when calling it with after_save' do
    expect(subject.author.posts_counter).to eq(1)
  end
end
