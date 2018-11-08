require 'journey'
require 'station'

describe Journey do

  # let(:oystercard) { double :oystercard, :in_journey? => false }
  let(:journey) {Journey.new}
  let(:oystercard) {OysterCard.new}
  let(:station_1) {Station.new('Victoria', 1)}
  let(:station_2) {Station.new('Aldgate', 1)}

  describe '#initialize' do
    it 'sets in journey to nil by default' do
      expect(journey.in_journey?).to eq nil
    end

    it 'sets the minimum fare to touch in with a default value of 1' do
      expect(journey.min_fare).to eq 1
    end
  end

  describe '#touch_in' do
    it 'changes oystercard status to in journey' do
      journey.touch_in(1, station_1)
      expect(journey.in_journey?).to eq true
    end

    it 'user is not allowed to touch if there is less than £1 in the balance' do
      message = 'You dont have suffient balance to touch in'
      expect { journey.touch_in(0, station_1) }.to raise_error message
    end
  end

  describe '#touch_out' do
    it 'changes oystercard status to not in journey' do
      journey.touch_in(1, station_1)
      journey.touch_out(station_2)
      expect(journey.in_journey?).to eq false
    end
  end


  describe '#entry_station' do
    it 'entry station is stored in the card' do
      expect(journey.touch_in(1, station_1)).to eq station_1
    end
  end

  describe '#journeys' do

    it 'checks that journeys list is empty by default' do
      expect(oystercard.journey_history).to eq []
    end

    it 'stores journeys into a hash' do
      journey.touch_in(1, station_1)
      journey.touch_out(station_2)
      oystercard.add_journey(journey)
      expect(oystercard.journey_history[0].entry_station).to eq station_1
      expect(oystercard.journey_history[0].end_station).to eq station_2
    end
  end

  it "knows if a journey is not complete" do
    expect(subject).not_to be_journey_complete
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "it charges the penalty fare if you don't touch out"  do
    oystercard.top_up(10)
    journey.touch_in(oystercard.balance, station_1)
    oystercard.deduct(journey.fare)

    expect(oystercard.balance).to eq 4
  end

  it "it charges the min fare if you touch in and touch out"  do
    oystercard.top_up(10)
    journey.touch_in(oystercard.balance, station_1)
    journey.touch_out(station_2)
    oystercard.deduct(journey.fare)

    expect(oystercard.balance).to eq 9
  end

end
