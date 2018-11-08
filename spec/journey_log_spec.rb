require 'journey_log'

describe JourneyLog do

  let(:station_1) { double :station_1, name: "Victoria", zone: 1 }
  let(:station_2) { double :station_2, name: "Mile End", zone: 2 }
  let(:journey) { double :journey,  start: station_1, finish: station_2 }

  describe '#initialize' do
    it "Sets journey history to an empty journey" do
      Journey.stub(:new) { journey }
      journey_log_2 = JourneyLog.new
      expect(journey_log_2.journeys).to include journey
    end
  end

  describe '#start' do
    it "Sets entry station to journey" do
      Journey.stub(:new) { journey }
      journey_log_2 = JourneyLog.new
      expect(journey).to receive(:start).with(station_1)
      journey_log_2.start(station_1)
    end
  end

  describe '#finish' do
    it "Sets finish station to journey" do
      Journey.stub(:new) { journey }
      journey_log_2 = JourneyLog.new
      expect(journey).to receive(:finish).with(station_1)
      journey_log_2.finish(station_1)
    end
  end

  describe '#complete_journey' do
    it "creates a new empty journey" do
      Journey.stub(:new) { journey }
      journey_log_2 = JourneyLog.new
      journey_log_2.complete_journey
      expect(journey_log_2.journeys[0]).to eq journey
    end
  end



end
