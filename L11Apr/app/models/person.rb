# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  name       :string
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Person < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  has_many :phones
  has_many :person_job
  has_many :jobs, through: :person_job

  before_validation :fill_name
  before_create :print_data

  private
  def fill_name
    if self.name.nil? || self.name.length <= 3
      self.name = "Guest"
    end
  end

  def print_data
    puts "#{self.name} : #{self.age}"
  end
end
