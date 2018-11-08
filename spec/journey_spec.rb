require 'journey'

describe Journey do

  let(:journey) { Journey.new }
  let(:station_1) { double :station_1, name: "Victoria", zone: 1 }
  let(:station_2) { double :station_2, name: "Mile End", zone: 2 }
  let(:station_5) { double :station_5, name: "Heathrow", zone: 5 }

  describe '#initialize' do
    it "sets journey paid state to false" do
      expect(journey.paid).to eq false
    end
  end

  describe '#start' do
    it 'changes oystercard status to in journey' do
      journey.start(station_1)
      expect(journey.in_journey?).to eq true
    end

  end

  describe '#finish' do
    it 'changes oystercard status to not in journey' do
      journey.start(station_1)
      journey.finish(station_2)
      expect(journey.in_journey?).to eq false
    end
  end

  describe "#fare" do
    it 'return 1 if all station zone 1' do
      journey.start(station_1)
      journey.finish(station_1)
      expect(journey.update_fare).to eq 1
    end

    it 'return 2 if station zone 2' do
      journey.start(station_2)
      journey.finish(station_1)
      expect(journey.update_fare).to eq 2
    end

    it 'return 3 if station zone 5' do
      journey.start(station_2)
      journey.finish(station_5)
      expect(journey.update_fare).to eq 3
    end

    it "return #{described_class::PENALTY_FARE} if journey not complete" do
      journey.finish(station_5)
      expect(journey.update_fare).to eq described_class::PENALTY_FARE
    end
  end

  describe '#entry_station' do
    it 'entry station is stored in the card' do
      journey.start(station_1)
      expect(journey.entry_station).to eq station_1
    end
  end

  it 'has a penalty fare by default' do
    expect(subject.update_fare).to eq Journey::PENALTY_FARE
  end

end
