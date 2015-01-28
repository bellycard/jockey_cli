require 'spec_helper'
require 'jockey_cli/reconcile'

describe JockeyCli::Reconcile do
  context 'configuration' do
    it 'is configured with the proper path' do
      expect(JockeyCli::Reconcile.path).to eq('/reconciles')
    end
  end

  context '#preview' do
    it 'passes the execpted params to the :post method' do
      expect(JockeyCli::Reconcile)
      .to receive(:post)
      .with('/reconciles/preview', body: {param1: true})

      JockeyCli::Reconcile.preview(param1: true)
    end
  end
end
