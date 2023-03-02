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
    it 'creates a reservation belonging to the guest' do
      post "/v1/reservations", params: { payload: payload }

      debugger

      expect(guest).to be_present
      expect(guest.email).to eq "wayne_woodbridge@bnb.com"

      expect(guest.reservations.size).to eq 1
      expect(guest.reservations.first.code).to eq reservation_code
      expect(guest.reservations.first.status).to eq "accepted"
      expect(guest.reservations.first.start_date).to eq "2021-04-14"
      expect(guest.reservations.first.end_date).to eq "2021-04-18"
    end

    it 'responds with the created resource' do
      post "/v1/reservations", params: { payload: payload }

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['code']).to eq "YYY12345678"
    end

    context 'when a payload can not be matched to any known partner' do
      let(:unknown_payload) { payload.except(:status) }

      it 'returns a bad request response' do
        post "/v1/reservations", params: { payload: unknown_payload }

        expect(reservation).not_to be_present
        expect(JSON.parse(response.body)['error_type']).to eq "ReservationPayloadClassifier::UnknownPayloadError"
        expect(response.status).to eq 400
      end
    end

    context 'when the payload of the request is missing or malformed' do
      let (:payload) { nil }
      
      it 'returns a bad request response' do
        post "/v1/reservations", params: { payload: payload }

        expect(reservation).not_to be_present
        expect(JSON.parse(response.body)['error']).to eq "Payload missing"
        expect(response.status).to eq 400
      end
    end
  end

  context 'updating a reservation' do
    before do
      post "/v1/reservations", params: { payload: payload }
    end

    it 'updates the reservation details from the submitted payload' do
      post "/v1/reservations", params: { payload: payload.merge("status" => "cancelled") }

      expect(reservation.status).to eq "cancelled"
      expect(guest.reservations.size).to eq 1
    end
  end
end