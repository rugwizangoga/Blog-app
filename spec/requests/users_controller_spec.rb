require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #show' do
    it 'returns a successful response' do
      user = User.create(name: 'paul', photo: 'https://pbs.twimg.com/media/FfhkDtjWQAMYNrc.jpg:large', bio: 'Teacher from Burundi.',
                         posts_counter: 0)
      get user_path(user.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      user = User.create(name: 'paul', photo: 'https://pbs.twimg.com/media/FfhkDtjWQAMYNrc.jpg:large', bio: 'Teacher from Burundi.',
                         posts_counter: 0)
      get user_path(user.id)
      expect(response).to render_template(:show)
    end

    describe 'GET #index' do
      it 'returns a successful response' do
        get users_path
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        get users_path
        expect(response).to render_template(:index)
      end

      it 'includes correct placeholder text in the response body' do
        User.create(name: 'paul', photo: 'https://pbs.twimg.com/media/FfhkDtjWQAMYNrc.jpg:large', bio: 'Teacher from Burundi.',
                    posts_counter: 0)
        User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/ABC123', bio: 'Lorem ipsum',
                    posts_counter: 0)
        get users_path
        expect(response.body).to include('<h1>Here is a list of all users</h1>')
      end
    end
  end
end
