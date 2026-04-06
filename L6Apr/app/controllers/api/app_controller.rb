class Api::AppController < ApplicationController
rescue_from LgError, with: :handle_400
rescue_from LgAuthenticationError, with: :handle_401
rescue_from JWT::ExpiredSignature, with: :handle_401
rescue_from JWT::Base64DecodeError, with: :handle_401
rescue_from JWT::DecodeError, with: :handle_401

def handle_400(exception)
  render json: { success: false, error: exception.message }, status: 400
end

def handle_401(exception)
  render json: { success: false, error: exception.message }, status: 401
end
end
