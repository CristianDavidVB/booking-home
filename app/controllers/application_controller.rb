class ApplicationController < ActionController::Base
  include Pagy::Backend

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      user_properties_path
    else
      super
    end
  end
end
