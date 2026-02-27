require 'rails_helper'

RSpec.describe Message, type: :model do
  subject(:message) { described_class.new(chatroom: create(:chatroom), user: create(:user), content: 'Hello') }

  it { is_expected.to validate_presence_of(:content) }
end
