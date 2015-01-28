require 'spec_helper'
require 'jockey_cli/configuration'

describe JockeyCli::Configuration do
  it "merges a local .jockeyrc file with the global .jockeyrc file" do
    expect(YAML).to(receive(:load_file).at_least(:once).with("#{ENV['HOME']}/.jockeyrc").and_return({ jockey_url: 'http://123.com', github_oauth_token: '12345'}))

    expect(File).to(receive(:exists?).at_least(:once).with('./.jockeyrc').and_return(true))
    expect(YAML).to(receive(:load_file).at_least(:once).with("./.jockeyrc").and_return({ 'jockey_url' => 'http://dev-123.com' }))

    expect(JockeyCli::Configuration.new.jockeyrc_config['jockey_url']).to eql('http://dev-123.com')
  end
end
