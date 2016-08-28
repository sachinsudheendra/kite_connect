require 'spec_helper'

describe KiteConnectClient do
  let(:client) {KiteConnectClient.new 'test_api_key'}
  let(:request_params) {
    {
      api_key: client.api_key,
      access_token: 'test_access_token'
    }
  }
  let(:token) {Token.new({access_token: 'test_access_token'})}

  before :each do
    client.instance_variable_set :@token , token
  end

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
      expect(Unirest).to receive(:post).with(Endpoints.url(Endpoints::TOKEN), parameters: request_params).and_return(TestResponse.token_success)
      token = client.request_access_token 'request_token', 'test_api_secret'
      expect(token).to_not be_nil
    end

    it 'should throw up when failed to retrieve token for the user' do
      expect(Unirest).to receive(:post).with(Endpoints.url(Endpoints::TOKEN), parameters: request_params).and_return(TestResponse.token_error)
      expect {
        token = client.request_access_token 'request_token', 'test_api_secret'
      }.to raise_error(RuntimeError)
    end
  end

  describe :logout do
    it 'should logout session' do
      expect(Unirest).to receive(:delete).with(Endpoints.url(Endpoints::LOGOUT), parameters: request_params).and_return(TestResponse.success)
      client.logout
      expect(client.token).to be_nil
    end

    it 'should not clear token if logout fails' do
      expect(Unirest).to receive(:delete).with(Endpoints.url(Endpoints::LOGOUT), parameters: request_params).and_return(TestResponse.error)
      expect {
        client.logout
      }.to raise_error(RuntimeError)
      expect(client.token).to be(token)
    end
  end

  describe :equity_margin do
    it 'should return equity margin' do
      expect(Unirest).to receive(:get).with(Endpoints.url(Endpoints::EQUITY_MARGIN), parameters: request_params).and_return(TestResponse.margin_success)
      margin = client.equity_margin
      expect(margin).to_not be_nil
      expect(margin[:enabled]).to be(true)
      expect(margin[:net]).to be(1230.0)
      expect(margin[:available]).to eq({
        "cash": 1110.0,
        "intraday_payin": 230.0,
        "adhoc_margin": 3230.0,
        "collateral": 43240.0
      })
      expect(margin[:utilised]).to eq({
        "m2m_unrealised": 0.0,
        "m2m_realised": 0.0,
        "debits": 0.0,
        "span": 0.0,
        "option_premium": 1230.0,
        "holding_sales": 23330.0,
        "exposure": 23285.85,
        "turnover": 0.0
      })
    end
  end
end
