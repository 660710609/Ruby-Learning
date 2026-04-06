class Project < ApplicationRecord
  has_many :assignments
  has_many :person, through: :assignments
end
