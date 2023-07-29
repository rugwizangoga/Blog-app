require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build(:post) }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(250) }
  it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
  it { should have_many(:comments) }
  it { should have_many(:likes) }

  describe '#five_most_recent_comments' do
    it 'returns the five most recent comments for the post' do
      post = create(:post)
      new_comments = create_list(:comment, 5, post:)
      create(:comment, post:, created_at: 4.days.ago)

      expect(post.five_most_recent_comments).to match_array(new_comments)
    end
  end
end
