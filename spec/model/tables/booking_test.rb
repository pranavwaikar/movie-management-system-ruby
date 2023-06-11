# frozen_string_literal: true

require './src/model/tables/booking'

RSpec.describe Booking do
  subject { Booking.new }

  describe '#create' do
    it 'Should be create the bookings entry' do
      expect(subject.create(1, 1, 100, 14, 1, 1,
                            116)).to eq({ id: 1, base_price: 100, krishikalyan_cess: 1, seat_id: 1,
                                          service_tax: 14, show_id: 1, swachh_bharat_cess: 1, total_price: 116 })
    end
  end
end
