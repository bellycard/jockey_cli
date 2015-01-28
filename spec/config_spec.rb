require 'spec_helper'
require 'jockey_cli/config'

describe JockeyCli::Config do
  context 'configuration' do
    it 'is configured with the proper path' do
      expect(JockeyCli::Config.path).to eq('/config_sets')
    end
  end
end
