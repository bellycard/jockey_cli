require 'spec_helper'
require 'jockey_cli/base'

describe JockeyCli::Base do
  before do
    module JockeyCli
      class Foo < Base
        self.path = '/foos'
      end
    end
  end

  context '#parsed_response' do
    it 'returns a Hashie::Mash object' do
      response = JockeyCli::Base.parsed_response(foo: 'bar')
      expect(response.class).to be(Hashie::Mash)
    end
  end

  context '#filter' do
    it 'passes the execpted params to the :get method' do
      expect(JockeyCli::Base)
      .to receive(:get)
      .with('/foos', query: {param1: true})

      JockeyCli::Foo.filter(param1: true)
    end
  end

  context '#find' do
    it 'passes the execpted params to the :get method' do
      expect(JockeyCli::Base)
      .to receive(:get)
      .with('/foos/123', query: {param1: true})

      JockeyCli::Foo.find(123, param1: true)
    end
  end

  context '#create' do
    it 'passes the execpted params to the :post method' do
      expect(JockeyCli::Base)
      .to receive(:post)
      .with('/foos', body: {param1: true, param2: false})

      JockeyCli::Foo.create(param1: true, param2: false)
    end
  end

  context '#update' do
    it 'passes the execpted params to the :post method' do
      expect(JockeyCli::Base)
      .to receive(:put)
      .with('/foos/123', body: {param1: true, param2: false})

      JockeyCli::Foo.update(123, param1: true, param2: false)
    end
  end

  context '#destroy' do
    it 'raises not implemented' do
      expect{
        JockeyCli::Foo.destroy
      }.to raise_error(RuntimeError)
    end
  end
end
