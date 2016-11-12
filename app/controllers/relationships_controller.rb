class RelationshipsController < ApplicationController

  def create
    request_user = RequestUser.find(params[:followed_id])
    current_volunteer_user.follow(request_user)
    redirect_to current_volunteer_user
  end

  def destroy
    volunteer_user = Relationship.find(params[:id]).followed
    current_volunteer_user.unfollow(volunteer_user)
    redirect_to current_volunteer_user
  end
end