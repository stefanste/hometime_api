module Classifiers
  class BookingDotCom
    TOP_LEVEL_KEYS = 1

    def self.payload_matches?(payload)
      payload.keys.size == TOP_LEVEL_KEYS &&
      payload['reservation'].present? &&
      payload.dig('reservation', 'code').present? &&
      payload.dig('reservation', 'guest_details', 'number_of_adults').present? &&
      payload['status'].nil?
    end
  end
end