module ReservationPresenters
  class BookingDotCom
    def initialize(payload)
      @payload = payload
    end

    def email
      payload.dig(:reservation, :guest_email)
    end

    def first_name
      payload.dig(:reservation, :guest_first_name)
    end

    def last_name
      payload.dig(:reservation, :guest_last_name)
    end

    def phone_numbers
      payload.dig(:reservation, :guest_phone_numbers)
    end

    def reservation_code
      payload.dig(:reservation, :code)
    end

    def status
      payload.dig(:reservation, :status_type)
    end

    def start_date
      payload.dig(:reservation, :start_date)
    end

    def end_date
      payload.dig(:reservation, :end_date)
    end

    def currency
      payload.dig(:reservation, :host_currency)
    end

    def payout_amount
      payload.dig(:reservation, :expected_payout_amount)
    end

    def security_amount
      payload.dig(:reservation, :listing_security_price_accurate)
    end

    def total_amount
      payload.dig(:reservation, :total_paid_amount_accurate)
    end

    def nights
      payload.dig(:reservation, :nights)
    end

    def total_number_of_guests
      payload.dig(:reservation, :number_of_guests)
    end

    def number_of_adults
      payload.dig(:reservation, :guest_details, :number_of_adults)
    end

    def number_of_children
      payload.dig(:reservation, :guest_details, :number_of_children)
    end

    def number_of_infants
      payload.dig(:reservation, :guest_details, :number_of_infants)
    end

    private

    attr_reader :payload
  end
end