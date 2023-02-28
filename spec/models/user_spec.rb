require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }

  before { subject.save }

  it 'please provide name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post counter should be equal or great than 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Subject should be valid' do
    expect(subject).to be_valid
  end

  it 'Returns 3 most recent posts' do
    subject.posts.create(title: 'My Title', text: 'First post')
    subject.posts.create(title: 'My Title', text: 'Second post')
    subject.posts.create(title: 'My Title', text: 'Third post')
    subject.posts.create(title: 'My Title', text: 'Fourth post')
    expect(subject.three_most_recent_posts.count).to eql(3)
  end
end
