class HomeController < ApplicationController
  skip_before_filter :authenticate, :only => [:index]

  def index
    @identities = current_user.identities
    @identity   = Identity.new(:user_id => current_user.id)
  end
end
