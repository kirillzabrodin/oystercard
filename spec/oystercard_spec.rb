require 'oystercard'

describe OysterCard do

  oystercard = (OysterCard.new)
  let(:journey_log) { double :journey_log,  start: "A station", finish: "A station", journey_log: true, complete_journey: true, pay: true}

  describe '#balance' do
    it 'returns the user balance' do
      expect(oystercard.balance).to eq 0
    end
  end

  it 'allows the user to top up their balance' do
    expect(subject.top_up(5)).to eq 5
  end

  it 'Adds the top up value to the balance' do
    subject.top_up(10)
    expect(subject.balance).to eq 10
  end

  it 'doesn"t allow the user to top up above card limit (£90)' do
    expect { subject.top_up(95) }.to raise_error "Your balance is currently #{subject.balance} and your limit is #{OysterCard::MAX_LIMIT}"
  end

  it 'doesnt" allow the user to top up when at limit' do
    subject.top_up(90)
    expect { subject.top_up(5) }.to raise_error "Your balance is currently #{subject.balance} and your limit is #{OysterCard::MAX_LIMIT}"
  end

  describe '#touch_in' do
    it "doesn't let you ride if balance too low" do
      expect { subject.touch_in("A station") }.to raise_error "Your balance is below #{OysterCard::MIN_FARE}"
    end

    it 'calls start on journey log' do
      JourneyLog.stub(:new) {journey_log}
      card = OysterCard.new
      card.top_up(90)
      expect(card.journey_log).to receive(:start).with("A station")
      card.touch_in("A station")
    end
  end

  describe '#touch_out' do
    it 'calls finish on journey log' do
      JourneyLog.stub(:new) {journey_log}
      card = OysterCard.new
      expect(card.journey_log).to receive(:finish).with("A station")
      card.touch_out("A station")
    end

    it 'calls finish on journey log' do
      JourneyLog.stub(:new) {journey_log}
      card = OysterCard.new
      expect(card.journey_log).to receive(:complete_journey)
      card.touch_out("A station")
    end
  end

  describe '#pay' do
    it 'calls finish on journey log' do
      expect(subject).to receive(:pay)
      subject.touch_out("A station")
    end
  end
end
