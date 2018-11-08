class JourneyLog

  attr_reader :journey_history

  def initialize(journey_class = Journey.new)
    @journey_class = journey_class
    @journey_history = []
  end

  def start(entry_station)
    @current_journey = entry_station
  end

  def finish(end_station)
    @current_journey = end_station
  end

  def journeys
    @journey_history.dup
  end

  def add_journey
    @journey_history << @current_journey
  end

  private

  def current_journey
    @current_journey ||= journey_class.new
  end

end
