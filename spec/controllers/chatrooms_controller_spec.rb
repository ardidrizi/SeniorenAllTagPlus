require 'rails_helper'

RSpec.describe ChatroomsController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:chatroom) { create(:chatroom) }

    before { sign_in user }

    it 'loads chatroom and its activity by chatroom id' do
      get :show, params: { id: chatroom.id }

      expect(response).to have_http_status(:ok)
      expect(assigns(:chatroom)).to eq(chatroom)
      expect(assigns(:activity)).to eq(chatroom.activity)
    end
  end
end
