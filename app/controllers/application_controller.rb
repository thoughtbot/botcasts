class ApplicationController < ActionController::Base
  before_action { request.variant << :turbo_frame if turbo_frame_request? }
end
