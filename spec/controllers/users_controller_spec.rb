require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'POST#create' do

    it 'should create a new user record and send a success json response' do
      params = { first_name: 'Toofan',last_name: 'Takatwar', phone_number: '9999999999', email_address: 'toofan@gmail.com' }
      post :create, params: params
      expect(response).to have_http_status(201)
      expect(json.keys).to match_array(["id", "phone_number", "first_name", "last_name", "email_address", "created_at", "updated_at"])
    end

    it 'should not create a new user when there is no phone_number provided by user' do
      params = { first_name: 'Toofan', last_name: 'Takatwar', email_address: 'toofan@gmail.com' }
      post :create, params: params
      expect(response).to have_http_status(400)
    end
  end
end
