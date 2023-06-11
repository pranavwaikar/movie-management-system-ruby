# frozen_string_literal: true

require './src/config/config_loader'

RSpec.describe ConfigLoader do
  describe '#get_attribute' do
    it 'Should get attribute from the config file' do
      expect(ConfigLoader.instance.get_attribute('LogFilePath')).to eq('./logs/combined.log')
    end
  end
end
