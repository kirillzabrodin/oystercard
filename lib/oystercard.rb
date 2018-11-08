require_relative 'journey_log'

class OysterCard

  attr_reader :balance
  MIN_FARE = 1
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90

  def initialize(journey_log_class = JourneyLog, min_fare = MIN_FARE, default_balance = DEFAULT_BALANCE, max_limit = MAX_LIMIT)
    @min_fare = min_fare
    @balance = default_balance
    @max_limit = max_limit
    @journey_log = journey_log_class.new
  end

  def touch_in(station)
    insufficient_funds?(@balance)
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    @journey_log.complete_journey
  end

  def top_up(value)
    fail "Your balance is currently #{@balance} and your limit is #{OysterCard::MAX_LIMIT}" if exceed_max_limit?(value)
    @balance += value
    value
  end

  def deduct(value)
    @balance -= value
    value
  end

  private

  def insufficient_funds?(balance)
    fail 'You dont have suffient balance to touch in' if balance < @min_fare
  end

  def exceed_max_limit?(value)
    (@balance + value) > @max_limit
  end

end
