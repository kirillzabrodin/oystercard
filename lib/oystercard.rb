require_relative 'journey_log'
require_relative 'station'

class OysterCard

  attr_reader :balance, :journey_log
  MINIMUM_CHARGE = 1
  MAX_LIMIT = 90

  def initialize(journey_log: JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
  end

  def top_up(amount)
    fail "Exceeds #{MAX_LIMIT}" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance to touch in." if balance < MINIMUM_CHARGE
    deduct(journey_log.outstanding_charges)
    journey_log.start_journey(station)
  end

  def touch_out(station)
    journey = journey_log.exit_journey(station)
    deduct(journey.fare)
  end

  private

  attr_reader :journey_log

  def over_limit?(amount)
    (amount + balance) > MAX_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

end
