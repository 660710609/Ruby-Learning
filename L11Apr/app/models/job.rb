# == Schema Information
#
# Table name: jobs
#
#  id         :bigint           not null, primary key
#  name       :string
#  salary     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Job < ApplicationRecord
  has_many :person_job
  has_many :persons, through: :person_job
end
