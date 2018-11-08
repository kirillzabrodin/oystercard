class Journey

  ZONE_FARE = [1,2,3,3,3]

  attr_reader :entry_station, :exit_station, :paid
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @paid = false
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
    @paid = true
    journey_complete? ? ZONE_FARE[zone_visited - 1] : PENALTY_FARE
  end

  private

  def journey_complete?
    @exit_station && @entry_station
  end

  def zone_visited
    [@entry_station.zone, @exit_station.zone].max
  end


end
