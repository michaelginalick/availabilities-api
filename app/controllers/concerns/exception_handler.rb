module ExceptionHandler

  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ errorMsg: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ errorMsg: e.message }, :unprocessable_entity)
    end

    rescue_from UnavailableDayError do |_e|
      json_response({ errorMsg: "Canidate not available for given date"}, :unprocessable_entity)
    end

    rescue_from UnavailableTimeError do |_e|
      json_response({ errorMsg: "Canidate not available for given time"}, :unprocessable_entity)
    end
  end
end
