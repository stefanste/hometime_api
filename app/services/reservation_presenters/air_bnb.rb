module ReservationPresenters
  class AirBnb
    def initialize(payload)
      @payload = payload
    end

    def email
      payload.dig('guest', 'email')
    end

    def first_name
      payload.dig('guest', 'first_name')
    end

    def last_name
      payload.dig('guest', 'last_name')
    end

    def phone_numbers
      payload.dig('guest', 'phone_numbers')
    end

    def reservation_code
      payload['reservation_code']
    end

    def status
      payload['status']
    end

    def start_date
      payload['start_date']
    end

    def end_date
      payload['end_date']
    end

    def currency
      payload['currency']
    end

    def payout_amount
      payload['payout_amount']
    end

    def security_amount
      payload['security_amount']
    end

    def total_amount
      payload['total_amount']
    end

    def nights
      payload['nights']
    end

    def total_number_of_guests
      payload['total_number_of_guests']
    end

    def number_of_adults
      payload['number_of_adults']
    end

    def number_of_children
      payload['number_of_children']
    end

    def number_of_infants
      payload['number_of_infants']
    end

    private

    attr_reader :payload
  end
end