# == Schema Information
#
# Table name: phone_numbers
#
#  id         :bigint           not null, primary key
#  label      :string
#  number     :string
#  person_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PhoneNumber < ApplicationRecord
  belongs_to :person
end
