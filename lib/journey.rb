
class Journey

  attr_reader :min_fare, :entry_station, :end_station, :fare, :penalty_fare
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(min_fare = MIN_FARE, penalty_fare = PENALTY_FARE)
    @min_fare = min_fare
    @penalty_fare = penalty_fare
    @entry_station = nil
    @end_station = nil
  end

  def touch_in(balance, station = nil)
    insufficient_funds?(balance)
    @entry_station = station
  end

  def touch_out(station)
    @end_station = station
  end

  def in_journey?
    @entry_station && !@end_station
  end

  def fare
    if journey_complete?
      @min_fare
    else
      @penalty_fare
    end
  end

  def journey_complete?
    @end_station
  end

  private

  def insufficient_funds?(balance)
    fail 'You dont have suffient balance to touch in' if balance < @min_fare
  end

end
