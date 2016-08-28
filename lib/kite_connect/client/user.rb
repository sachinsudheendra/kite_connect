module Client
  module User
    def equity_margin
      margin Endpoints::EQUITY_MARGIN
    end

    def commodity_margin
      margin Endpoints::COMMODITY_MARGIN
    end

    private

    def margin path
      response = Unirest.get Endpoints.url(path), parameters: default_params
      if response.code == 200 && response.body['status'] == KiteResponse::SUCCESS
        return response.body['data']
      else
        fail response
      end
    end
  end
end
