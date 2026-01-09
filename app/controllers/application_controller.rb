class ApplicationController < ActionController::Base
  # Browser check disabled - was blocking some browsers
  # allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
