class ReservationPayloadClassifier
  class UnknownPayloadError < StandardError; end

  PARTNERS = {
    'AIRBNB' => Classifiers::AirBnb,
    'BOOKING.COM' => Classifiers::BookingDotCom
  }

  def self.call(payload)
    new(payload).call
  end

  def initialize(payload)
    @payload = payload
  end

  def call
    classification = PARTNERS.detect do |partner, classifier_class|
      classifier_class.payload_matches?(@payload)
    end

    raise UnknownPayloadError, @payload.to_json unless classification.present?

    classification.first
  end
end