# app/channels/application_cable/connection.rb
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      token = request.query_parameters[:token]

      # ใช้กุญแจเดียวกับที่เขียนใน Model User
      secret = Rails.application.credentials.secret_key_base

      begin
        # ถอดรหัสด้วยกุญแจและ Algorithm ที่คุณกำหนด
        decoded_token = JWT.decode(token, secret, true, { algorithm: "HS256" })

        # ดึง auth_token (UUID) ออกมาตามโครงสร้างที่คุณ Encode ไว้
        token_payload = decoded_token[0]
        auth_token = token_payload["auth_token"]

        # ค้นหา User จาก auth_token ใน Database
        if verified_user = User.find_by(auth_token: auth_token)
          verified_user
        else
          puts "--- [ActionCable] User not found with this auth_token ---"
          reject_unauthorized_connection
        end
      rescue => e
        puts "--- [ActionCable] JWT Error: #{e.message} ---"
        reject_unauthorized_connection
      end
    end
  end
end
