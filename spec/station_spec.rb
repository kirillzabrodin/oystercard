require 'station'

describe Station do

  let(:station) {Station.new('Victoria', 1)}

  it 'should return station name' do
    expect(station.name).to eq 'Victoria'
  end

  it 'should return station zone' do
    expect(station.zone).to eq 1
  end




end
