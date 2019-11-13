# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  controller_login_user
  describe 'GET /new ' do
    it 'responds with 200 when logged in' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /' do
    it 'responds with 200' do
      pending
      post :create, params: { post: { message: 'Hello, world!' } }
      expect(response).to redirect_to(posts_url)
    end
  end
      # it "creates a post" do
      #   post :create, params: { post: { message: "Hello, world!" } }
      #   expect(Post.find_by(message: "Hello, world!")).to be
      # end
  

  describe 'GET /' do
    it 'responds with 200 when logged in' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
