class ReservationsController < ApplicationController
  before_action :validate_payload, only: :upsert

  def upsert
    reservation_source = ReservationPayloadClassifier.call(params[:payload])

    reservation = UpsertReservation.call(reservation_source, params[:payload])

    render json: reservation
  rescue StandardError => e
    render json: { error_type: e.class, error_message: e.message}, status: :bad_request
  end

  private

  def validate_payload
    return if params[:payload].present?

    render json: { error: 'Payload missing' }, status: :bad_request
  end
end