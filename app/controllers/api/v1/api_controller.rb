class Api::V1::ApiController < ApplicationController
  # Not calling from browser, so CSRF protection not useful
  # Real world would have actual authentication/authorization logic to prevent unfettered use
  skip_forgery_protection


end
