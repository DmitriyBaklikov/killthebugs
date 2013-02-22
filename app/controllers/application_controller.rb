class ApplicationController < ActionController::Base
  protect_from_forgery

  def can_edit_fragment(fragment_id)

    return true if Fragment.find(fragment_id).user_id == current_user.id
    return false
    
  end
end
