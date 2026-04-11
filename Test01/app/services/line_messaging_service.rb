require "line/bot"

class LineMessagingService
  def initialize
    @client = Line::Bot::V2::MessagingApi::ApiClient.new(
      channel_access_token: Rails.application.credentials.line_channel_token
    )
    # @user_id = Rails.application.credentials.line_user_id
  end

  def send_text(message_text)
    # puts "--- Debug: Start send_text ---"
    # return puts "Error: No User ID" unless @user_id.present?

    begin
      # ตรวจสอบค่าก่อนส่ง
      puts "Debug: User ID = #{@user_id}"
      puts "Debug: Token exists? #{@client.instance_variable_get(:@channel_access_token).present?}"

      text_message = Line::Bot::V2::MessagingApi::TextMessage.new(text: message_text)

      push_request = Line::Bot::V2::MessagingApi::BroadcastRequest.new(
        messages: [ text_message ]
      )

      puts "Debug: Sending request..."
      response = @client.broadcast(broadcast_request: push_request)

      puts "Debug: Success! Response = #{response.inspect}"
      response
    rescue Exception => e  # ใช้ Exception เพื่อดักจับ Error ทุกประเภท
      puts "--- !!! LINE PUSH ERROR !!! ---"
      puts "Type: #{e.class}"
      puts "Message: #{e.message}"
      puts "Backtrace: #{e.backtrace.first(3).join("\n")}"
      nil
    end
  end
end
