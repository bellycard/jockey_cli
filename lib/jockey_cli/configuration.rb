module JockeyCli
  class << self
    def configuration
      @configuration ||= JockeyCli::Configuration.new
    end
  end

  class Configuration
    def jockeyrc_config
      begin
        @jockeyrc_config = YAML.load_file("#{ENV['HOME']}/.jockeyrc")
      rescue
        raise "Error loading .jockeyrc file"
      end
      @jockeyrc_config.merge! local_jockeyrc_config
      @jockeyrc_config
    end

    def local_jockeyrc_config
      File.exists?("./.jockeyrc") ? YAML.load_file("./.jockeyrc") : {}
    end

    def base_url
      ENV['JOCKEY_URL'] || jockeyrc_config['jockey_url']
    end

    def github_access_token
      ENV['JOCKEY_OAUTH_TOKEN'] || jockeyrc_config['github_oauth_token']
    end

    def method_missing(sym, *args, &block)
      jockeyrc_config[sym.to_s]
    end
  end
end
