require 'spec_helper'
require 'jockey_cli/worker'

describe JockeyCli::Worker do
  context 'configuration' do
    it 'is configured with the proper path' do
      expect(JockeyCli::Worker.path).to eq('/workers')
    end
  end

  context '#deploys' do
    it 'passes the execpted params to the :get method' do
      expect(JockeyCli::Worker)
      .to receive(:get)
      .with('/workers/123/deploys', query: {param1: true})

      JockeyCli::Worker.deploys(123, param1: true)
    end
  end

  context '#restart' do
    it 'passes the execpted params to the :put method' do
      expect(JockeyCli::Worker)
      .to receive(:put)
      .with('/workers/restart', body: {param1: true})

      JockeyCli::Worker.restart(param1: true)
    end
  end
end
