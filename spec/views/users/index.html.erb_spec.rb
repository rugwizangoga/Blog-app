require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before do
    @users_with_posts = create_list(:user, 5, :with_posts)
    visit users_path
  end

  it 'displays the username, profile picture, and number of posts for each user' do
    @users_with_posts.each do |user|
      expect(page).to have_css('.user-details h3', text: user.name)
      expect(page).to have_css('.photo img') # Assuming there's an img tag for the photo
      expect(page).to have_css('.user-posts', text: "Number of Posts: #{user.posts.count}")
    end
  end
end
