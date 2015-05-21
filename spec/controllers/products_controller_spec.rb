require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    subject(:dispatch) { get :index }

    it "responds successfully with an HTTP 200 status code" do
      dispatch
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "responds event stream" do
      dispatch
      expect(response.header['Content-Type']).to eq 'text/event-stream'
    end

    it "responds orders as json string" do
      first_product = Product.create(name: 1)
      second_product = Product.create(name: 2)

      dispatch
      expect(response.body).to include first_product.to_json
      expect(response.body).to include second_product.to_json
      expect(response.body).not_to include Product.create.to_json
    end

    it "stream closed after response" do
      dispatch
      expect(response.stream.closed?).to be_truthy
    end
  end
end
