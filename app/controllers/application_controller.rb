class ApplicationController < ActionController::Base
  before_action :basic_auth

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username,password|
      username == 'admin' && password == '0722'
      # username == ENV["BASIC_AUTH_USER"] && password ==["BASIC_AUTH_PASSWORD"]
    end
  end
end
