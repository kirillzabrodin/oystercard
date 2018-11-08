require 'oystercard'

describe OysterCard do
  oystercard = (OysterCard.new)

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

    it 'doesnt" allow the user to top up the balance above the max limit' do
      subject.top_up(90)
      expect { subject.top_up(5) }.to raise_error "Your balance is currently #{subject.balance} and your limit is #{OysterCard::MAX_LIMIT}"
    end

    describe '#deduct' do
      it ' Allows a fair to be deducted from the card' do
        subject.top_up(10)
        expect(subject.deduct(7)).to eq 7
      end

      it 'Deducts the fair from the balance' do
        subject.top_up(10)
        subject.deduct(7)
        expect(subject.balance).to eq 3
      end

    end
end
