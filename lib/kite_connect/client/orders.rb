module Client
  module Orders
    def orders
      response = Unirest.get Endpoints.url(Endpoints::ORDERS), parameters: default_params
      if response.code == 200 && response.body['status'] == KiteResponse::SUCCESS
        return response.body['data']
      else
        fail response
      end
    end
  end
end
