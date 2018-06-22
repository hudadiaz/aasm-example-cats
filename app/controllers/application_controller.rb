class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session
  add_flash_types :error, :warning
end
