require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

	describe "On loggin in" do
		before :each do 
    	@user = FactoryGirl.create(:user_login)
		end

    it "should redirect to root url" do
      post :create, FactoryGirl.attributes_for(:login_credentials)
      response.should redirect_to root_url
    end

    it "should have set session variable" do
      post :create,  FactoryGirl.attributes_for(:login_credentials)
      session[:user_id].should be_eql @user.id
    end
  end

  describe "mail verification" do
  	before :each do 
      @user = FactoryGirl.create(:user_login)
		end

		it "should verify and redirect to login" do
	  	get :verification, :email_token => @user.registration_token
		  response.should redirect_to log_in_path
		end
		it "should redirect to sign up page if invalid" do
	  	get :verification, :email_token => "1234567890"
		  response.should redirect_to sign_up_path
		end
  end

  describe "Log out" do
  	it "should clear sessions" do
	  	delete :destroy
  	  session[:user_id].should be_nil
  	end
  end

end
