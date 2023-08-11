require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before do
    @user = create(:user, :with_posts)
    @most_recent_posts = @user.posts.order(created_at: :desc).limit(3)
  end

  context 'Displaying User Information' do
    before { visit user_path(@user) }

    it 'displays the user\'s profile picture' do
      expect(page).to have_css('.photo img')
    end

    it 'displays the user\'s username' do
      expect(page).to have_content(@user.name)
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_content("Number of Posts: #{@user.posts.count}")
    end

    it 'displays the user\'s bio' do
      expect(page).to have_content(@user.bio)
    end

    it 'displays the user\'s first 3 posts' do
      @most_recent_posts.each do |post|
        expect(page).to have_content("Post ##{post.id}")
        expect(page).to have_content(post.text)
        expect(page).to have_content("comments: #{post.comments_counter}, Likes: #{post.likes_counter}")
      end
    end
  end

  context 'Interactions' do
    before { visit user_path(@user) }

    it 'redirects to the user\'s posts index page when clicking "Show More" button' do
      click_link 'Show More'
      expect(page).to have_current_path(user_posts_path(@user))
    end

    it 'redirects to the clicked post\'s show page when clicking on a post' do
      post_to_click = @most_recent_posts.first
      click_link "Post ##{post_to_click.id}" # Assuming the link text follows this format

      expect(current_path).to eq(user_post_path(@user, post_to_click))
    end
  end
end
