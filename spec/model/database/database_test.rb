# frozen_string_literal: true

require './src/model/database/database'

RSpec.describe InMemoryStorage do
  describe '#SCREENS' do
    it 'Should be an instance of Screen' do
      expect(Database.SCREENS.class.to_s).to eq('Screen')
    end
  end

  describe '#SEAT_CATEGORIES' do
    it 'Should be an instance of SeatCategory' do
      expect(Database.SEAT_CATEGORIES.class.to_s).to eq('SeatCategory')
    end
  end

  describe '#SEATS' do
    it 'Should be an instance of Seat' do
      expect(Database.SEATS.class.to_s).to eq('Seat')
    end
  end

  describe '#SHOWS' do
    it 'Should be an instance of show' do
      expect(Database.SHOWS.class.to_s).to eq('Show')
    end
  end

  describe '#BOOKINGS' do
    it 'Should be an instance of bookings' do
      expect(Database.BOOKINGS.class.to_s).to eq('Booking')
    end
  end
end
