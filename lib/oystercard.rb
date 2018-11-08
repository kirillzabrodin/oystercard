require_relative 'journey'

class OysterCard

  attr_reader :balance #:journey_history

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90

  def initialize(default_balance = DEFAULT_BALANCE, max_limit = MAX_LIMIT)
    @balance = default_balance
    @max_limit = max_limit
    # @journey_history = []
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

  def exceed_max_limit?(value)
    (@balance + value) > @max_limit
  end

end
