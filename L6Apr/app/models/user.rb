# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_name             :text
#  last_name              :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  auth_token             :string
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :generate_auth_token

  def generate_auth_token
    self.auth_token = SecureRandom.uuid
  end

  def jwt(exp = 15.days.from_now)
    JWT.encode({ auth_token: self.auth_token, exp: exp.to_i }, Rails.application.credentials.secret_key_base, "HS256")
  end

  def as_json_with_jwt
    json = {}
    json[:email] = self.email
    json[:first_name] = self.first_name
    json[:last_name] = self.last_name
    json[:jwt] = self.jwt
    json
  end

  def as_profile_json
    json = {}
    json[:email] = self.email
    json[:first_name] = self.first_name
    json[:last_name] = self.last_name
    json
  end
end
