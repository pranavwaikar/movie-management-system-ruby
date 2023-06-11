# frozen_string_literal: true

require './src/view/view'
require './src/model/database/database'

RSpec.describe View do
  before(:all) do
    Database.seed
  end

  after(:all) do
    Database.truncate
  end

  let(:view) { View.new }

  describe '#take_seat_input' do
    it 'Should accept single seat number as input' do
      allow(view).to receive(:gets).and_return("A1\n")
      expect(view.take_seat_input).to eq(['A1'])
    end

    it 'Should accept single seat number with white space as input' do
      allow(view).to receive(:gets).and_return("A1  \n")
      expect(view.take_seat_input).to eq(['A1'])
    end

    it 'Should accept comma separated multiple seat number as input' do
      allow(view).to receive(:gets).and_return("A1,A2,B1\n")
      expect(view.take_seat_input).to eq(%w[A1 A2 B1])
    end

    it 'Should accept comma separated multiple seat number with extra white spaces as input' do
      allow(view).to receive(:gets).and_return("A1, A2,   B1\n")
      expect(view.take_seat_input).to eq(%w[A1 A2 B1])
    end

    it 'Should convert small case to uppercase' do
      allow(view).to receive(:gets).and_return("a1, a2,   B1\n")
      expect(view.take_seat_input).to eq(%w[A1 A2 B1])
    end
  end

  describe '#show_all_seating_charts' do
    it 'Should return the seating chart' do
      expected_data = JSON.parse(File.read('./spec/mocks/all_shows.json'), { symbolize_names: true })
      expect(view.show_all_seating_charts).to eq(expected_data)
    end
  end
end
