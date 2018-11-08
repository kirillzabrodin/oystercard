require_relative 'journey'

class OysterCard

  attr_reader :balance #:journey_history
  MIN_FARE = 1
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90

  def initialize(min_fare = MIN_FARE, default_balance = DEFAULT_BALANCE, max_limit = MAX_LIMIT)
    @min_fare = min_fare
    @balance = default_balance
    @max_limit = max_limit
    # @journey_history = []
  end

  def touch_in(balance, station = nil)
    insufficient_funds?(balance)
    @entry_station = station
  end

  def touch_out(station)
    @end_station = station
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

  # def add_journey(journey)
  #   @journey_history << journey
  # end

  private

  def insufficient_funds?(balance)
    fail 'You dont have suffient balance to touch in' if balance < @min_fare
  end

  def exceed_max_limit?(value)
    (@balance + value) > @max_limit
  end

end
