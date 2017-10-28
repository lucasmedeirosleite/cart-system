# frozen_string_literal: true

class APIController < ActionController::Base
  protect_from_forgery with: :null_session
end
