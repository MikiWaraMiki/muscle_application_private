class TodoPost < ApplicationRecord
  belongs_to :todo
  belongs_to :post
end
