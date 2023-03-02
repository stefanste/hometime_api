require 'rails_helper'

RSpec.describe ReservationPresenters::BookingDotCom do
  let(:payload) {
    {
      "reservation": {
        "code": "XXX12345678",
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
          "localized_description": "4 guests",
          "number_of_adults": 2,
          "number_of_children": 2,
          "number_of_infants": 0
        },
        "guest_email": "wayne_woodbridge@bnb.com",
        "guest_first_name": "Wayne",
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
          "639123456789",
          "639123456789"
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "accepted",
        "total_paid_amount_accurate": "4300.00"
      }
    }
  }

  let(:subject) { described_class.new(payload) }

  it 'provides all the required fields' do
    expect(subject.email).to eq "wayne_woodbridge@bnb.com"
    expect(subject.first_name).to eq "Wayne"
    expect(subject.last_name).to eq "Woodbridge"
    expect(subject.phone_numbers).to eq ["639123456789", "639123456789"]
    expect(subject.reservation_code).to eq "XXX12345678"
    expect(subject.status).to eq "accepted"
    expect(subject.start_date).to eq "2021-03-12"
    expect(subject.end_date).to eq "2021-03-16"
    expect(subject.currency).to eq "AUD"
    expect(subject.payout_amount).to eq "3800.00"
    expect(subject.security_amount).to eq "500.00"
    expect(subject.total_amount).to eq "4300.00"
    expect(subject.nights).to eq 4
    expect(subject.total_number_of_guests).to eq 4
    expect(subject.number_of_adults).to eq 2
    expect(subject.number_of_children).to eq 2
    expect(subject.number_of_infants).to eq 0
  end
end