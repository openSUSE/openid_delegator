class IdentitiesController < ApplicationController
  include OpenidInspector
  respond_to :html, :js

  def index
    @identities = current_user.identities
  end

  def create
    @identity = Identity.new(params[:identity])
    @identity.user = current_user
    
    reply = inspect_openid_page(@identity.openid_url)
    if reply[:status]
      @identity.openid_server   = reply[:openid_server]
      @identity.openid_delegate = reply[:openid_delegate]
    end

    @identity.save

    if !reply[:status]
      @identity.errors.set(:openid_delegate, reply[:error])
    end

    respond_with @identity, :location => home_url
  end

  def destroy
    @identity = Identity.find(params[:id])
    @identity.destroy

    respond_with @identity, :location => home_url
  end

  def show_by_username
    params[:username] =~ /(\A\w+)(\+\d+)?/
    @username = $1

    @identity = Identity.find_by_name @username
    if @identity.nil?
      head :bad_request
    else
      respond_to do |format|
        format.html
        format.xml  { render :xml => @identity }
      end
    end
  end

end
