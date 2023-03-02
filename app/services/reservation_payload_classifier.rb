class ReservationPayloadClassifier
  class UnknownPayloadError < StandardError; end

  # When adding new partners, it is important to ensure only one payload classification matches;
  # add to tests in spec for this class to ensure this continues to be the case.
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