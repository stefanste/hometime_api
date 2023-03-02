module ReservationPresenters
  class AirBnb
    def initialize(payload)
      @payload = payload
    end

    def email
      payload.dig(:guest, :email)
    end

    def first_name
      payload.dig(:guest, :first_name)
    end

    def last_name
      payload.dig(:guest, :last_name)
    end

    def phone_numbers
      payload.dig(:guest, :phone)
    end

    def reservation_code
      payload[:reservation_code]
    end

    def status
      payload[:status]
    end

    def start_date
      payload[:start_date]
    end

    def end_date
      payload[:end_date]
    end

    def currency
      payload[:currency]
    end

    def payout_amount
      payload[:payout_price]
    end

    def security_amount
      payload[:security_price]
    end

    def total_amount
      payload[:total_price]
    end

    def nights
      payload[:nights]
    end

    def total_number_of_guests
      payload[:guests]
    end

    def number_of_adults
      payload[:adults]
    end

    def number_of_children
      payload[:children]
    end

    def number_of_infants
      payload[:infants]
    end

    private

    attr_reader :payload
  end
end