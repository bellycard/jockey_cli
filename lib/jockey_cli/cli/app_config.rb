class AppConfig < ThorCli
  namespace 'config'
  default_task :get

  desc 'get', 'Get environment variables for an app'
  def get
    response = JockeyCli::Config.filter(app: app, environment: environment)
    config_set = response.data.first

    if config_set
      render_config_set(config_set.config)
    else
      say(response.error.message, :red)
    end

  end

  desc 'set', 'Set an environment variable for an app'
  def set(*settings)
    response = JockeyCli::Config.filter(app: app, environment: environment)
    config_set = response.data.first

    if response.data
      config = {}

      settings.each do |setting|
        config[setting.split("=",2)[0]]=setting.split("=",2)[1]
      end

      updated_config = config_set.config.merge!(config)

      response = JockeyCli::Config.update(
        config_set.id,
        config: config
      )

      render_config_set(config_set.config, config.keys)
    else
      say(response.error.message, :red)
    end

  end

  private

    def render_config_set(config, highlight = [])
      config.each do |key, value|
        if highlight.include?(key)
          say("#{key}=#{value}", :yellow)
        else
          say("#{key}=#{value}", :green)
        end
      end
    end
end
