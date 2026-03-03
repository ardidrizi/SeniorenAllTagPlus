require 'rails_helper'

RSpec.describe 'Safety smoke checks', type: :request do
  it 'returns 200 for root when logged out' do
    get root_path

    expect(response).to have_http_status(:ok)
  end

  it 'returns 200 for activities index when logged out' do
    get activities_path

    expect(response).to have_http_status(:ok)
  end
end
