require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    before(:each) { get :index }
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "assigns a list of :stats_names" do
      expect( assigns(:stats_names) ).to be_an_instance_of( Array )
    end
  end
  #-- -------------------------------------------------------------------------
  #++

  describe "GET #detail" do
    it "returns http success" do
      get :detail
      expect(response).to have_http_status(:success)
    end
  end
  #-- -------------------------------------------------------------------------
  #++

  describe "DELETE #destroy" do
    it "redirects to home#index" do
      Redis.current.multi                           # Crude transaction start
      delete :destroy, stats_name: Redis.current.keys.first
      expect(response).to redirect_to( home_index_path() )
      Redis.current.discard                         # Crude transaction rollback
    end
  end
  #-- -------------------------------------------------------------------------
  #++
end
