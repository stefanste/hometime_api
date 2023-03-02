require 'rails_helper'

RSpec.describe "The reservations endpoint", type: :request do
  let(:payload) {
    {
      "reservation_code": reservation_code,
      "start_date": "2021-04-14",
      "end_date": "2021-04-18",
      "nights": 4,
      "guests": 4,
      "adults": 2,
      "children": 2,
      "infants": 0,
      "status": "accepted",
      "guest": {
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": email
      },
      "currency": "AUD",
      "payout_price": "4200.00",
      "security_price": "500",
      "total_price": "4700.00"
    }
  }
  let(:reservation_code) { "YYY12345678" }
  let(:email) { "wayne_woodbridge@bnb.com" }
  let(:reservation) { Reservation.find_by(code: reservation_code) }
  let(:guest) { Guest.find_by(email: email) }

  context 'creating a reservation' do
    it 'persists a reservation with the corresponding details' do
      post "/v1/reservations", params: { payload: payload }

      expect(reservation).to exist 
      expect(reservation.status).to eq "accepted"
      expect(reservation.start_date).to eq "2021-04-14"
      expect(reservation.end_date).to eq "2021-04-18"
    end

    it 'creates a reservation belonging to the guest' do
      post "/v1/reservations", params: { payload: payload }

      expect(guest).to be_present
      expect(guest.email).to eq "wayne_woodbridge@bnb.com"

      expect(guest.reservations.size).to eq 1
      expect(guest.reservations.first.code).to eq reservation_code
    end

    context 'when the payload of the request is missing or malformed' do
      let (:payload) { nil }
      
      it 'returns a bad request response' do
        post "/v1/reservations", params: { payload: payload }

        expect(reservation.present?).to be false
        expect(response.status).to eq 400
      end
    end
  end

  context 'updating a reservation' do
    before do
      post "/v1/reservations", params: { payload: payload }
    end

    it 'updates the reservation details from the submitted payload' do
      post "/v1/reservations", params: payload.merge("status" => "cancelled")

      expect(reservation.status).to eq "cancelled"
    end
  end
end