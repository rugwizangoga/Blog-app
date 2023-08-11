require 'rails_helper'

RSpec.feature 'User Post Index Page', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    create_list(:post, 10, :with_comments, :with_likes, author: user)
    visit user_posts_path(user)
  end

  scenario 'displaying user information' do
    expect(page).to have_css('.user .photo img')
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of Posts: #{user.posts.count}")
  end

  scenario 'displaying posts' do
    expect(page).to have_selector('.bio-posts .recent-posts', count: 10)
  end

  scenario 'clicking on a post redirects to its show page' do
    first_post = user.posts.first
    click_link "Post ##{first_post.id}"
    expect(page).to have_current_path(user_post_path(user, first_post))
  end

  scenario "can see a post's title, first comments, and number of likes" do
    first_post = user.posts.first

    expect(page).to have_content(first_post.title)
    expect(page).to have_content(first_post.comments.first.text)
    expect(page).to have_content("Likes: #{first_post.likes_counter}")
  end

  scenario 'can see a section for pagination' do
    expect(page).to have_css('.pagination')
  end
end
