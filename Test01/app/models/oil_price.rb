# == Schema Information
#
# Table name: oil_prices
#
#  id         :bigint           not null, primary key
#  date       :date
#  fuel_type  :string
#  price      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OilPrice < ApplicationRecord
end
