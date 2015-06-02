require 'rails_helper'

describe UsersController, :type => :controller do
  before :each do
    @user = create(:user)
    @invalid_user = build(:user, email: nil)
    session[:user_id] = @user.id
  end

  describe 'GET #show' do
    it 'assigns the requested user to @user' do
      get :show, id: @user
      expect(assigns(:user)).to eq @user
    end

    it 'renders the :show template' do
      get :show, id: @user
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new User to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the #new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user to @user' do
      get :edit, id: @user
      expect(assigns(:user)).to eq @user
    end

    it 'renders #edit template' do
      get :edit, id: @user
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before :each do
      @user_attributes = attributes_for(:user)
    end

    context 'with valid attributes' do
      it 'saves the new user in the database' do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it 'redirects to users#index' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user in the database' do
        expect{
          post :create,
            user: attributes_for(:invalid_user)
        }.not_to change(User, :count)
      end

      it 're-renders the :new template' do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @user = create(:user,
        name: 'Larry Bird',
        email: 'high@inthesky.com')
    end

    context "valid attributes" do
      it 'locates the requested user' do
        patch :update, id: @usre, user: attributes_for(:user)
        expect(assigns(:user)).to eq(@user)
      end

      it 'changes @user\'s attributes' do
        patch :update, id: @user,
          user: attributes_for(:user,
            name: 'Royston Keane',
            email: 'loop@daloop.com')
        @user.reload
        expect(@user.name).to eq('Royston Keane')
        expect(@user.email).to eq('loop@daloop.com')
      end

      it 'redirect_to root_url' do
        patch :update, id: @user, user: attributes_for(:user)
        expect(response).to redirect_to root_url
      end
    end

    context "with invalid attributes" do
      it "does not change the user's attributes" do
        patch :update, id: @user,
           user: attributes_for(:user,
            name: 'Barnaby', email: nil)
        @user.reload
        expect(@user.name).not_to eq('Barnaby')
        expect(@user.email).to eq('high@inthesky.com')
      end

      it "re-renders the :edit template" do
       patch :update, id: @user,
        user: attributes_for(:invalid_user)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @user = create(:user)
    end

    it 'deletes the user' do
      expect{
        delete :destroy, id: @user
      }.to change(User, :count).by(-1)
    end

    it 'redirects to root_url' do
      delete :destroy, id: @user
      expect(response).to redirect_to root_url
    end
  end
end
