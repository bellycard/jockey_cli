require 'spec_helper'
require 'jockey_cli/app'

describe JockeyCli::App do
  context 'configuration' do
    it 'is configured with the proper path' do
      expect(JockeyCli::App.path).to eq('/apps')
    end
  end

  context '#available_node' do
    it 'passes the execpted params to the :get method' do
      expect(JockeyCli::App)
      .to receive(:get)
      .with('/apps/available_node', query: {param1: true})

      JockeyCli::App.available_node(param1: true)
    end
  end
end
