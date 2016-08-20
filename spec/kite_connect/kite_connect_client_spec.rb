require 'spec_helper'

describe KiteConnectClient do
  let(:client) {KiteConnectClient.new 'test_api_key', 'test_access_token'}

  describe :login_url do
    it 'should return login url for given api key' do
      expect(client.login_url).to eq 'https://api.kite.trade/connect/login?api_key=test_api_key'
    end
  end
end
