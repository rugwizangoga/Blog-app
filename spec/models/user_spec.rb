require 'rails_helper'
RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  it { should have_many(:posts).dependent(:destroy).with_foreign_key(:author_id) }

  describe '#three_most_recent_posts' do
    it 'returns the three most recent posts' do
      user = create(:user)
      old_post = create(:post, author: user, created_at: 4.days.ago)
      new_post1 = create(:post, author: user, created_at: 2.days.ago)
      new_post2 = create(:post, author: user, created_at: 1.day.ago)
      expect(user.three_most_recent_posts).to eq([new_post2, new_post1, old_post])
    end
  end
end
