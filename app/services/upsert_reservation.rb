class UpsertReservation
  PARTNERS = {
    'AIRBNB' => ReservationPresenters::AirBnb,
    'BOOKING.COM' => ReservationPresenters::BookingDotCom
  }

  def self.call(reservation_source, payload)
    new(reservation_source, payload).call
  end

  def initialize(reservation_source, payload)
    @reservation_source = reservation_source
    @payload = payload
  end

  def call
    guest = Guest.find_or_create_by!(email: payload_presenter.email)
    guest.update!(
      first_name: payload_presenter.first_name,
      last_name: payload_presenter.last_name,
      phone_numbers: payload_presenter.phone_numbers
    )

    reservation = Reservation.find_or_create_by!(code: payload_presenter.reservation_code, guest_id: guest.id)
    reservation.update!(
      status: payload_presenter.status,
      start_date: payload_presenter.start_date,
      end_date: payload_presenter.end_date,
      currency: payload_presenter.currency,
      payout_amount: payload_presenter.payout_amount,
      security_amount: payload_presenter.security_amount,
      total_amount: payload_presenter.total_amount,
      nights: payload_presenter.nights,
      total_number_of_guests: payload_presenter.total_number_of_guests,
      number_of_adults: payload_presenter.number_of_adults,
      number_of_children: payload_presenter.number_of_children,
      number_of_infants: payload_presenter.number_of_infants
    )

    reservation
  end

  private

  attr_reader :payload, :reservation_source

  def payload_presenter
    @payload_presenter ||= PARTNERS[reservation_source].new(payload)
  end
end