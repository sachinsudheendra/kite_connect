require 'spec_helper'

describe KiteConnectClient do
  let(:client) {KiteConnectClient.new 'test_api_key'}

  describe :login_url do
    it 'should return login url for given api key' do
      expect(client.login_url).to eq 'https://api.kite.trade/connect/login?api_key=test_api_key'
    end
  end

  describe :request_access_token do
    let(:request_params) {
      {
        api_key: client.api_key,
        request_token: 'request_token',
        checksum: Digest::SHA256.digest("#{client.api_key}request_tokentest_api_secret")
      }
    }

    it 'should retrieve token for the user' do
      response = TestResponse.new(200, {'status' => 'success', 'data' => {}})
      expect(Unirest).to receive(:post).with(Endpoints.construct_url(Endpoints::TOKEN), parameters: request_params).and_return(response)
      token = client.request_access_token 'request_token', 'test_api_secret'
    end

    it 'should throw up when failed to retrieve token for the user' do
      response = TestResponse.new(400, {'status' => 'error', 'data' => {}})
      expect(Unirest).to receive(:post).with(Endpoints.construct_url(Endpoints::TOKEN), parameters: request_params).and_return(response)
      expect {
        token = client.request_access_token 'request_token', 'test_api_secret'
      }.to raise_error(RuntimeError)
    end
  end
end
