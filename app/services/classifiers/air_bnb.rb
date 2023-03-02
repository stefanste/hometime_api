module Classifiers
  class AirBnb
    TOP_LEVEL_KEYS = 14

    def self.payload_matches?(payload)
      payload.keys.size == TOP_LEVEL_KEYS &&
      payload['reservation_code'].present? &&
      payload['status'].present? &&
      payload.dig('guest', 'email').present? &&
      payload['reservation'].nil?
    end
  end
end