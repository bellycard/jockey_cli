require 'thor'

module JockeyCli
  class Cli < Thor
    desc "version", "Shows the Jockey version number"
    def version
      say JockeyCli::VERSION
    end

    desc 'settings', 'Show the current jockeyrc settings'
    def settings
      puts JockeyCli.configuration.to_yaml
    end

    desc 'config (get|set)', 'Get or set app configuration'
    subcommand 'config', ::AppConfig

    desc 'scale (get|set)', 'Get or set the scale settings for an app'
    subcommand 'scale', ::Scale

    desc 'connect [COMMAND]', 'Run a command within the context of an app'
    subcommand 'connect', ::Connect

    desc 'deploy', 'Deploy an app'
    subcommand 'deploy', ::Deploy

    desc 'reconcile', 'Reconcile an app'
    subcommand 'reconcile', ::Reconcile
  end
end
