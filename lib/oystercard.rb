require_relative 'journey_log'
require_relative 'station'

class OysterCard

  attr_reader :balance, :journey_log
  MIN_FARE = 1
  MAX_LIMIT = 90

  def initialize(journey_log_class = JourneyLog)
    @balance = 0
    @journey_log = journey_log_class.new
  end

  def touch_in(station)
    deduct(@journey_log.pay) if @journey_log.last_incomplete
    insufficient_funds?(@balance)
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    complete_journey
    deduct(@journey_log.pay)
  end

  def top_up(value)
    fail "Your balance is currently #{@balance} and your limit is #{OysterCard::MAX_LIMIT}" if exceed_max_limit?(value)
    @balance += value
  end

  private

  def complete_journey
    @journey_log.complete_journey
  end

  def deduct(value)
    @balance -= value
  end

  def insufficient_funds?(balance)
    fail "Your balance is below #{OysterCard::MIN_FARE}" if balance < MIN_FARE
  end

  def exceed_max_limit?(value)
    (@balance + value) > MAX_LIMIT
  end

end
