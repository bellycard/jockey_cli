require 'jockey_cli'

RSpec.configure do |config|
  config.before(:each) do
    allow_any_instance_of(JockeyCli::Configuration).to receive(:base_url).and_return('http://example.com')
    allow_any_instance_of(JockeyCli::Configuration).to receive(:github_oauth_token).and_return('12345')
  end
end
