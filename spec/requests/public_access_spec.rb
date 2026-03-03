require 'rails_helper'

RSpec.describe 'Public access', type: :request do
  let!(:category) { create(:category, name: 'Wellness') }
  let!(:owner) { create(:user, email: 'owner@example.com') }
  let!(:public_activity) do
    create(:activity, :public_preview,
           category: category,
           owner: owner,
           name: 'Park Yoga',
           address: 'Berlin, Mitte',
           description: 'Gentle outdoor movement')
  end
  let!(:private_activity) { create(:activity, category: category, owner: owner, public: false, name: 'Private Walk') }

  describe 'GET /' do
    it 'returns 200 for logged out users' do
      get root_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('How it works')
    end
  end

  describe 'GET /activities' do
    it 'returns 200 for logged out users' do
      get activities_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Public activities preview')
      expect(response.body).to include(public_activity.name)
      expect(response.body).not_to include(private_activity.name)
    end
  end

  describe 'GET /activities/:id' do
    it 'returns 200 for a public activity when logged out' do
      get activity_path(public_activity)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(public_activity.name)
      expect(response.body).to include('Create or Join activities')
    end

    it 'redirects to login for a private activity when logged out' do
      get activity_path(private_activity)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'private areas' do
    it 'redirects logged out users to login' do
      get dashboard_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'privacy on public pages' do
    it 'does not expose user email or phone-like values' do
      get activities_path

      expect(response.body).not_to include(owner.email)
      expect(response.body).not_to match(/\+?\d[\d\s\-]{7,}/)
    end
  end
end
