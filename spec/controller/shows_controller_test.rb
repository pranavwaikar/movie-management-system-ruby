# frozen_string_literal: true

require './src/controller/seats_controller'
require './src/model/database/database'

RSpec.describe ShowsController do
  before(:all) do
    Database.seed
  end

  after(:all) do
    Database.truncate
  end

  subject { ShowsController.new }

  describe '#get_screen_id' do
    it 'Should get the screen id from the show id' do
      expect(subject.get_screen_id(1)).to eq(1)
    end

    it 'Should get negative value if screen id does not exists' do
      expect(subject.get_screen_id(100)).to eq(-1)
    end
  end

  describe '#get_all_seats' do
    it 'Should get all the seats' do
      expect(subject.get_all_seats(1)).to eq(
        [{ name: 'A1', seat_category_id: 1, screen_id: 1, id: 1 },
         { name: 'A2', seat_category_id: 1, screen_id: 1, id: 2 },
         { name: 'A3', seat_category_id: 1, screen_id: 1, id: 3 },
         { name: 'B1', seat_category_id: 2, screen_id: 1, id: 4 },
         { name: 'B2', seat_category_id: 2, screen_id: 1, id: 5 },
         { name: 'B3', seat_category_id: 2, screen_id: 1, id: 6 },
         { name: 'C1', seat_category_id: 3, screen_id: 1, id: 7 },
         { name: 'C2', seat_category_id: 3, screen_id: 1, id: 8 },
         { name: 'C3', seat_category_id: 3, screen_id: 1, id: 9 }]
      )
    end

    it 'Should get negative value if seat does not exists' do
      expect(subject.get_all_seats(200)).to eq(-1)
    end
  end

  describe '#get_available_seats' do
    it 'Should get all available the seats' do
      expect(subject.get_available_seats(1)).to eq(
        [{ name: 'A2', seat_category_id: 1, screen_id: 1, id: 2 },
         { name: 'A3', seat_category_id: 1, screen_id: 1, id: 3 },
         { name: 'B1', seat_category_id: 2, screen_id: 1, id: 4 },
         { name: 'B2', seat_category_id: 2, screen_id: 1, id: 5 },
         { name: 'B3', seat_category_id: 2, screen_id: 1, id: 6 },
         { name: 'C1', seat_category_id: 3, screen_id: 1, id: 7 },
         { name: 'C2', seat_category_id: 3, screen_id: 1, id: 8 },
         { name: 'C3', seat_category_id: 3, screen_id: 1, id: 9 }]
      )
    end

    it 'Should get nil value if seat does not exists' do
      expect(subject.get_available_seats(200)).to eq(nil)
    end
  end

  describe '#get_all_bookings' do
    it 'Should get all bookings for given show' do
      expect(subject.get_all_bookings(1)).to eq(
        [{ base_price: 320, id: 1, krishikalyan_cess: 1.5, seat_id: 1, service_tax: 42, show_id: 1,
           swachh_bharat_cess: 1.5, total_price: 365.0 }]
      )
    end

    it 'Should get empty value if show does not exists for getting bookings' do
      expect(subject.get_all_bookings(200)).to eq([])
    end
  end

  describe '#get_seat_map_with_status' do
    it 'Should get seat map with status for given show' do
      expect(subject.get_seat_map_with_status(1)).to eq(
        [
          { name: 'A1', seat_category_id: 1, screen_id: 1, id: 1, status: 'BOOKED' },
          { name: 'A2', seat_category_id: 1, screen_id: 1, id: 2, status: 'AVAILABLE' },
          { name: 'A3', seat_category_id: 1, screen_id: 1, id: 3, status: 'AVAILABLE' },
          { name: 'B1', seat_category_id: 2, screen_id: 1, id: 4, status: 'AVAILABLE' },
          { name: 'B2', seat_category_id: 2, screen_id: 1, id: 5, status: 'AVAILABLE' },
          { name: 'B3', seat_category_id: 2, screen_id: 1, id: 6, status: 'AVAILABLE' },
          { name: 'C1', seat_category_id: 3, screen_id: 1, id: 7, status: 'AVAILABLE' },
          { name: 'C2', seat_category_id: 3, screen_id: 1, id: 8, status: 'AVAILABLE' },
          { name: 'C3', seat_category_id: 3, screen_id: 1, id: 9, status: 'AVAILABLE' }
        ]
      )
    end

    it 'Should get negative value if show does not exists for seat map' do
      expect(subject.get_seat_map_with_status(200)).to eq(-1)
    end
  end
end
