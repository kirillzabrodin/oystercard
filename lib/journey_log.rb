require_relative 'journey'

class JourneyLog

  NO_CHARGE = 0

  def initialize(journey_class: Journey)
      @journey_class = journey_class
      @journeys = []
    end

    def start_journey(station)
      fail 'Already in a Journey.' if current_journey.entry_station
      add(journey_class.new(entry_station: station))
    end

    def exit_journey(station)
      current_journey.exit(station)
    end

    def journeys
      @journeys.dup
    end

    def outstanding_charges
      incomplete_journey ? incomplete_journey.exit.fare : NO_CHARGE
    end

    private
    attr_reader :journey_class

    def incomplete_journey
      journeys.reject(&:complete?).first
    end

    def current_journey
      incomplete_journey || journey_class.new
    end

    def add(journey)
      @journeys << journey
    end

end
