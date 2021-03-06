require 'rails_helper'
include SessionsHelper

RSpec.describe FavoritesController, type: :controller do

  let(:my_user) {
    create(:user)
  }

  let(:my_topic) {
    create(:topic)
  }

  let(:my_post) {
    create(:post, topic: my_topic, user: my_user)
  }

  let(:other_user) {
    create(:user)
  }

  let(:other_topic) {
    create(:topic)
  }

  let(:other_post) {
    create(:post, topic: other_topic, user: other_user)
  }

  context 'guest user' do

    describe 'POST create' do
      it 'redirects the user to the sign in view' do
        post :create, params: {
          post_id: my_post.id
        }
        expect(response).to redirect_to(new_session_path)
      end
    end

   describe 'DELETE destroy' do
     it 'redirects the user to the sign in view' do
       favorite = my_user.favorites.where(post: my_post).create
       delete :destroy, params: { post_id: my_post.id, id: favorite.id }
       expect(response).to redirect_to(new_session_path)
     end
   end

  end

  context 'signed in user' do

    before do
      create_session(my_user)
    end

    describe 'POST create' do
      it 'redirects to the posts show view' do
        post :create, params: {
          post_id: my_post.id
        }
        expect(response).to redirect_to([my_topic, my_post])
      end
      it 'creates a favorite for the current user and specified post' do
<<<<<<< HEAD
=======
        expect(my_user.favorites.find_by_post_id(other_post.id)).to be_nil
>>>>>>> checkpoint-31-public-profiles
        post :create, params: {
          post_id: other_post.id
        }
        expect(my_user.favorites.find_by_post_id(other_post.id)).not_to be_nil
      end
    end

    describe 'DELETE destroy' do
      it 'redirects to the posts show view' do
        favorite = my_user.favorites.where(post: other_post).create
        delete :destroy, params: { post_id: my_post.id, id: favorite.id }
        expect(response).to redirect_to([my_topic, my_post])
      end
      it 'destroys the favorite for the current user and post' do
<<<<<<< HEAD

        diff_user = User.create!(
          name: "other bloccit user",
          email: "OTHERUSER@bloccit.com",
          password: "password"
        )
        diff_post = my_topic.posts.create!(
          title: RandomData.random_sentence,
          body: RandomData.random_paragraph,
          user: diff_user
        )
        favorite = my_user.favorites.where(post: diff_post).create

        delete :destroy, params: {
          post_id: diff_post.id,
          id: favorite.id
        }
        expect(my_user.favorites.find_by_post_id(diff_post.id)).to be_nil
=======
        favorite = my_user.favorites.where(post: other_post).create
        expect( my_user.favorites.find_by_post_id(other_post.id) ).not_to be_nil
        delete :destroy, params: { post_id: other_post.id, id: favorite.id }
        expect( my_user.favorites.find_by_post_id(other_post.id) ).to be_nil
>>>>>>> checkpoint-31-public-profiles
      end
    end

  end

end
