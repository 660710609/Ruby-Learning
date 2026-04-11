# == Schema Information
#
# Table name: person_jobs
#
#  id         :bigint           not null, primary key
#  person_id  :bigint           not null
#  job_id     :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PersonJob < ApplicationRecord
  belongs_to :person
  belongs_to :job
end
