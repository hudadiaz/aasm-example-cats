class ApplicationController < ActionController::Base
  add_flash_types :error, :warning
  protect_from_forgery with: :exception
end
