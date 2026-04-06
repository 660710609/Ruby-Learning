# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  name       :string
#  lastname   :string
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Person < ApplicationRecord
  has_many :phone_number, dependent: :destroy
  has_many :assignments
  has_many :projects, through: :assignments
end
