require_relative 'journey'
require_relative 'station'

class JourneyLog

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey_history = []
    @journey_history.unshift(@journey_class.new)
  end

  def start(entry_station)
    @journey_history[0].start(entry_station)
  end

  def finish(end_station)
    @journey_history[0].finish(end_station)
  end

  def journeys
    @journey_history.dup
  end

  def complete_journey
    @journey_history.unshift(@journey_class.new)
  end

  def pay
    @journey_history[0].update_fare
  end

end
