class ThorCli < Thor
  class_option :app, aliases: [:a]
  class_option :environment, aliases: [:env, :e]

  no_commands do
    def app
      return options[:app] if options[:app]

      # take from the git remote name
      begin
        g = Git.open(Dir.pwd)
        upstream = g.remotes.select { |remote| remote.name == 'origin' }.first
        upstream.url.split('/').last.gsub('.git', '')
      rescue ArgumentError
        raise_app_not_found
      end
    end

    def environment
      options[:environment] || 'production'
    end

    def raise_app_not_found
      say "App not found, please pass in the --app flag", :red
      exit
    end
  end
end
