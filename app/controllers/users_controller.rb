class UsersController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def show
    user = User.find_by(id: params[:id])

    if user
    render json: user, include: :items
    else 
      render json: {error: "user not found"}, status: :not_found
    end
  end



end
