class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

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

  protected
  #  protected is like a private except that it prevents
  # descendent classes from using protected methods

  def record_not_found(error)
    render(
      status: 404,
      json: {
        status: 404,
        errors: [{
          type: error.class.to_s,
          message: error.message
          }]
        }
      )
  end

  def record_invalid(error)
    invalid_record = error.record
    errors = invalid_record.errors.map do |field, message|
      {
        type: error.class.to_s, #need it in string format
        record_type: invalid_record.class.to_s,
        field: field,
        message: message
      }
    end
    render(
      json: { status: 422, errors: errors },
      status: :unprocessable_entity
    )
  end
end
