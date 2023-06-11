# frozen_string_literal: true

require './src/model/repository/in_memory_storage'

RSpec.describe InMemoryStorage do
  subject { InMemoryStorage.new }

  describe '#create' do
    it 'Should create a new entry' do
      expect(subject.create({ foo: 'foo' })).to eq({ foo: 'foo', id: 1 })
    end
  end

  describe '#all' do
    it 'Should return all the entries' do
      expect(subject.all).to eq([])
    end
  end

  describe '#update' do
    it 'Should update the given entry' do
      subject.create({ foo: 'foo' })
      expect(subject.update({ foo: 'update', id: 1 })).to eq({ foo: 'update', id: 1 })
    end
  end

  describe '#delete' do
    it 'Should delete the entry' do
      subject.create({ foo: 'foo' })
      expect(subject.delete(1)).to eq({ foo: 'foo', id: 1 })
      expect(subject.all).to eq([])
    end
  end

  describe '#find' do
    it 'Should find the entry' do
      subject.create({ foo: 'foo' })
      expect(subject.find(1)).to eq({ foo: 'foo', id: 1 })
    end

    it 'Should return nil if unable to find the entry' do
      expect(subject.find(1)).to eq(nil)
    end
  end

  describe '#find_by' do
    it 'Should find the entry by some attribute' do
      subject.create({ foo: 'foo' })
      expect(subject.find_by('foo', 'foo')).to eq({ foo: 'foo', id: 1 })
    end

    it 'Should return nil if unable to find the entry by some attribute' do
      expect(subject.find_by('foo', 'foo')).to eq(nil)
    end
  end

  describe '#filter_by' do
    it 'Should filter the entry by some attribute' do
      subject.create({ foo: 'foo' })
      expect(subject.filter_by('foo', 'foo')).to eq([{ foo: 'foo', id: 1 }])
    end

    it 'Should return nil if unable to filter the entry by some attribute' do
      expect(subject.filter_by('foo', 'foo')).to eq([])
    end
  end

  describe '#find_index_by_id' do
    it 'Should find the index of an entry by id' do
      subject.create({ foo: 'foo' })
      expect(subject.find_index_by_id(1)).to eq(0)
    end

    it 'Should return nil if unable to filter the entry by some attribute' do
      expect(subject.find_index_by_id(1)).to eq(-1)
    end
  end
end
