# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  helper_method :current_cart

  private

  def current_cart
    @_current_cart ||= CartService.new.current_cart(user: current_user)
  end
end
