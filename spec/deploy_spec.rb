require 'spec_helper'
require 'jockey_cli/deploy'

describe JockeyCli::Deploy do
  context 'configuration' do
    it 'is configured with the proper path' do
      expect(JockeyCli::Deploy.path).to eq('/deploys')
    end
  end
end
