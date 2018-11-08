class Journey

  attr_reader :entry_station, :exit_station, :paid, :fare
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @paid = false
    @fare = MIN_FARE
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

  def update_fare
    @fare = fare
  end

  private

  def fare
    @paid = true
    journey_complete? ? zone_crossed + 1 : PENALTY_FARE
  end

  def journey_complete?
    @exit_station && @entry_station
  end

  def zone_crossed
    (@entry_station.zone - @exit_station.zone).abs
  end


end
