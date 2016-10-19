require 'spec_helper'

def app
  ApplicationApi
end

describe CheckInsApi do
  include Rack::Test::Methods

  describe 'POST /checkins' do
    let(:user) { create :user }
    let(:business) { create :business }

    context 'given valid parameters' do
      it 'returns a JSON string with the new check-in data' do
        args = { 
          user_id: user.id, 
          business_id: business.id, 
          business_token: business.token 
        }
        post '/checkins', args

        expect(response_body).to match(/data.*id.*/)
      end
    end

    context 'given invalid parameters' do
      it 'returns an error message' do
        args = { 
          user_id: user.id, 
          business_id: business.id, 
          business_token: "Jedi"
        }
        post '/checkins', args

        expect(response_body).to match(/error.*message/)
      end
    end

    it 'requires user_id' do
      args = { 
        business_id: business.id, 
        business_token: business.token 
      }
      post '/checkins', args

      expect(response_body).to match(/error.*message.*user_id/)
    end

    it 'requires business_id' do
      args = { 
        user_id: user.id, 
        business_token: business.token 
      }
      post '/checkins', args

      expect(response_body).to match(/error.*message.*business_id/)
    end

    it 'requires a business_token' do
      args = { 
        user_id: user.id, 
        business_id: business.id 
      }
      post '/checkins', args
      
      expect(response_body).to match(/error.*message.*business_token/)
    end
  end

end
