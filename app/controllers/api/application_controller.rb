class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token

  # To send a json error message when a user types in, for example: localhost:3000/api/v1/wrongthing
  def not_found
    render(
      json: {
        errors: [{
          type: "Not Found"
        }]
      },
      status: :not_found #alias for 404 in rails
    )
  end

  private

  def authenticate_user!
    unless current_user.present?
      render(json: { status: 401 }, status: 401)
    end
  end
end
