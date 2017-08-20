require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:my_post) {
    Post.create!(
      title: RandomData.random_sentence,
      body: RandomData.random_paragraph
    )
  }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_post] to @posts" do
      get :index
      expect(assigns(:posts)).to eq([my_post])
    end
  end

  # New method renders a new, unsaved post.
  describe "GET #new" do
    # Check for HTTP success code.
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    # Verify that the correct template (view) is rendered.
    it "renders the #new view" do
      get :new
      expect(response).to render_template(:new)
    end
    # 'assigns' gives us access to the @post variable, assigning it to :post, so we can check that the @post instance variable (now = to :post) was initialized by PostsController#new.
    it "instantiates post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {
        id: my_post.id
      }
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, params: {
        id: my_post.id
      }
      expect(response).to render_template(:show)
    end
    it "assigns my_post to @post" do
      get :show, params: {
        id: my_post.id
      }
      expect(assigns(:post)).to eq(my_post)
    end
  end

  # Create will persist the #new view by saving it to the database.
  describe "POST #create" do
    # Check that creation of a Post results in an increase in # of posts.
    it "increases the number of Post by 1" do
       expect{ post :create, params: {
         post: {
           title: RandomData.random_sentence,
           body: RandomData.random_paragraph
           }
         }
       }.to change(Post,:count).by(1)
     end
    # Expect a newly created post to be assigned to @post.
    it "assigns the new post to @post" do
      post :create, params: {
        post: {
          title: RandomData.random_sentence,
          body: RandomData.random_paragraph
        }
      }
      expect(assigns(:post)).to eq Post.last
    end
    # Expect to be redirected to newly created post (latest one).
    it "redirects to the new post" do
      post :create, params: {
        post: {
          title: RandomData.random_sentence,
          body: RandomData.random_paragraph
        }
      }
      expect(response).to redirect_to Post.last
    end
  end

end
