class Product < ActiveRecord::Base
  BATCH_SIZE = 10

  def self.stream_products
    offset = 0
    count  = self.count

    while count > BATCH_SIZE * offset
      limit(BATCH_SIZE).offset(BATCH_SIZE * offset).each do |product|
        yield product
      end

      offset += 1
    end
  end
end
