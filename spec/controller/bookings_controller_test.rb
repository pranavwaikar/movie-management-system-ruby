# frozen_string_literal: true

require './src/controller/bookings_controller'
require './src/model/database/database'

RSpec.describe BookingsController do
  before(:all) do
    Database.seed
  end

  after(:all) do
    Database.truncate
  end

  subject { BookingsController.new }

  describe '#create' do
    it 'Should be create the bookings entry' do
      expect(subject.create(1, 2)).to eq({ id: 2, base_price: 320, krishikalyan_cess: 1.5, seat_id: 2,
                                           service_tax: 42, show_id: 1, swachh_bharat_cess: 1.5, total_price: 365.0 })
    end

    it 'Should not create booking for already booked seat' do
      expect(subject.create(1, 1)).to eq(-1)
    end
  end

  describe '#show' do
    it 'Should show the bookings entry' do
      expect(subject.show(1)).to eq({ krishikalyan_cess: 1.5,
                                      service_tax: 42, swachh_bharat_cess: 1.5, total_price: 365.0,
                                      swachh_bharat_cess_percentage: 0.5,
                                      subtotal: 320, service_tax_percentage: 14,
                                      krishikalyan_cess_percentage: 0.5,
                                      show: { id: 1, screen_id: 1, show_date: '10 Feb 2020',
                                              show_name: 'show 1', show_time: '12:00 PM' },
                                      seat: { id: 1, name: 'A1',
                                              screen_id: 1, seat_category_id: 1 } })
    end

    it 'Should not show booking if not booked' do
      expect(subject.show(3)).to eq(-1)
    end
  end

  describe '#seat_available?' do
    it 'Should return true if seat available' do
      expect(subject.seat_available?(1, 3)).to eq(true)
    end

    it 'Should return false if seat is booked' do
      expect(subject.seat_available?(2, 2)).to eq(false)
    end
  end

  describe '#calculate_base_price' do
    it 'Should return base price for given seat id' do
      expect(subject.calculate_base_price(1)).to eq(320)
    end

    it 'Should not get base price if seat is invalid' do
      expect(subject.calculate_base_price(200)).to eq(-1)
    end
  end

  describe '#calculate_service_tax' do
    it 'Should return service tax price for given seat id' do
      expect(subject.calculate_service_tax(100)).to eq(14)
    end

    it 'Should not get service tax if service tax price is invalid' do
      expect(subject.calculate_service_tax('foo')).to eq(nil)
    end
  end

  describe '#calculate_krishi_kalyan_cess' do
    it 'Should return krishi_kalyan_cess price for given seat id' do
      expect(subject.calculate_krishi_kalyan_cess(100)).to eq(0.5)
    end

    it 'Should not get krishi_kalyan_cess if krishi_kalyan_cess price is invalid' do
      expect(subject.calculate_krishi_kalyan_cess('foo')).to eq(nil)
    end
  end

  describe '#calculate_swatch_bharat_cess' do
    it 'Should return swatch_bharat_cess price for given seat id' do
      expect(subject.calculate_swatch_bharat_cess(100)).to eq(0.5)
    end

    it 'Should not get swatch_bharat_cess if swatch_bharat_cess price is invalid' do
      expect(subject.calculate_swatch_bharat_cess('foo')).to eq(nil)
    end
  end

  describe '#get_revenue_stats' do
    it 'Should return complete revenue stats' do
      expect(subject.get_revenue_stats).to eq({ base_revenue: 640, krishi_kalyan_cess: 3.0, service_tax_revenue: 84,
                                                swatch_bharat_cess: 3.0 })
    end
  end
end
