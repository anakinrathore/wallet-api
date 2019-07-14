require 'rails_helper'

RSpec.describe GroupsController, type: :controller do

  describe 'POST#create' do

    it 'should create a new group record and send a success json response' do
      user = create(:user)
      params = { kind: "Friends", user_id: user.id }
      post :create, params: params
      expect(response).to have_http_status(201)
      expect(Group.first.users.first.id).to eq user.id
      expect(json.keys).to match_array(["id", "kind", "created_at", "updated_at"])
    end
  end
end
