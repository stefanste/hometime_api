require 'rails_helper'

RSpec.describe ReservationPresenters::AirBnb do
  let(:payload) {
    {
      "reservation_code": "YYY12345678",
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
        "email": "wayne_woodbridge@bnb.com",
      },
      "currency": "AUD",
      "payout_price": "4200.00",
      "security_price": "500",
      "total_price": "4700.00"
    }
  }

  let(:subject) { described_class.new(payload) }

  it 'provides all the required fields' do
    expect(subject.email).to eq "wayne_woodbridge@bnb.com"
    expect(subject.first_name).to eq "Wayne"
    expect(subject.last_name).to eq "Woodbridge"
    expect(subject.phone_numbers).to eq "639123456789"
    expect(subject.reservation_code).to eq "YYY12345678"
    expect(subject.status).to eq "accepted"
    expect(subject.start_date).to eq "2021-04-14"
    expect(subject.end_date).to eq "2021-04-18"
    expect(subject.currency).to eq "AUD"
    expect(subject.payout_amount).to eq "4200.00"
    expect(subject.security_amount).to eq "500"
    expect(subject.total_amount).to eq "4700.00"
    expect(subject.nights).to eq 4
    expect(subject.total_number_of_guests).to eq 4
    expect(subject.number_of_adults).to eq 2
    expect(subject.number_of_children).to eq 2
    expect(subject.number_of_infants).to eq 0
  end
end