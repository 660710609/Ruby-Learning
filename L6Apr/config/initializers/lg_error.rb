Rails.configuration.to_prepare do
  class LgError < StandardError
  end

  class LgAuthenticationError < StandardError
  end
end
