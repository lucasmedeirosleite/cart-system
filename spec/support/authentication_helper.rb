# frozen_string_literal

module AuthenticationHelper
  def authenticate(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end
end
