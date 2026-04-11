class Api::V1::AppController < ApplicationController
  rescue_from JWTError, with: :handle_404

  private
  def handle_404(exception)
    render json: { success: false, message: exception.message }, status: 404
  end
end
