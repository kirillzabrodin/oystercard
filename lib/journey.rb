class Journey

  attr_reader :entry_station, :exit_station
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
 end

  def in_journey?
    @entry_station && !@exit_station
  end

  def fare
    journey_complete? ? MIN_FARE : PENALTY_FARE
  end

  def journey_complete?
    @end_station
  end

  private

  # def insufficient_funds?(balance)
  #   fail 'You dont have suffient balance to touch in' if balance < @min_fare
  # end

end
