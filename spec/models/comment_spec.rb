require 'rails_helper'
RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  it { should belong_to(:post) }
  it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
end
