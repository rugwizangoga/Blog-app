require 'rails_helper'
RSpec.feature 'Post Show Page', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }
  before do
    @comment1 = FactoryBot.create(:comment, post:)
    @comment2 = FactoryBot.create(:comment, post:)
    visit user_post_path(user, post)
  end
  scenario 'displaying post details and comments' do
    expect(page).to have_content(post.author.name)
    expect(page).to have_content("comments: #{post.comments_counter}")
    expect(page).to have_content("Likes: #{post.likes_counter}")
    expect(page).to have_content(post.text)
    expect(page).to have_content(@comment1.author.name)
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.author.name)
    expect(page).to have_content(@comment2.text)
  end
end
