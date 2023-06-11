# frozen_string_literal: true

require './src/model/tables/show'

RSpec.describe Show do
  subject { Show.new }

  describe '#create' do
    it 'Should be create the Show entry' do
      expect(subject.create('foo', '10/02/1999', '3:00PM',
                            1)).to eq({ id: 1, show_name: 'foo', screen_id: 1, show_date: '10/02/1999',
                                        show_time: '3:00PM' })
    end
  end
end
