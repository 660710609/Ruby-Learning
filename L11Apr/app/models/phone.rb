# == Schema Information
#
# Table name: phones
#
#  id         :bigint           not null, primary key
#  person_id  :bigint           not null
#  label      :string
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Phone < ApplicationRecord
  belongs_to :person
end
