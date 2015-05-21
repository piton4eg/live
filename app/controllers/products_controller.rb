class ProductsController < ApplicationController
  include ActionController::Live

  def index
    response.headers['Content-Type'] = 'text/event-stream'

    response.stream.write "Test\n"
    Product.stream_products do |product|
      response.stream.write "#{product.to_json}\n"
    end
  ensure
    response.stream.close
  end
end
