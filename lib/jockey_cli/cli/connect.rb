class Connect < ThorCli
  namespace 'connect'
  default_task :connect

  desc 'set', 'Set the scale settings for an app'
  option :ref, type: :string
  def connect(*command)
    exec_command(command.join(' '), app, environment)
  end

  no_commands do
    def exec_command(command, app, environment)
      response = JockeyCli::Config.filter(app: app, environment: environment)
      node = JockeyCli::App.available_node(app: app, environment: environment)

      if response.error || node.error
        errors = [response.error.message, node.error.message]
        say "Error connecting, you probably need to pass in --app", :red
        say "Error message(s): #{errors.join(', ')}", :red
        exit
      end

      config_set = response.data.first
      server_address = node.data['address']

      docker_command_parts = []
      docker_command_parts << "docker pull registry.bellycard.com/#{app}:#{ref(options)} &&"
      docker_command_parts << "docker run -i -t --rm #{config_set.config_command_line_args} registry.bellycard.com/#{app}:#{ref(options)}"


      command_parts = []
      command_parts << "ssh -t"
      command_parts << host_with_user(server_address, JockeyCli.configuration.ssh_user)
      command_parts << "'#{docker_command_parts.join(' ')} #{command}'"

      exec(command_parts.join(' '))
    end
  end

  private
    def host_with_user(host, user = nil)
      user ? "#{user}@#{host}" : host
    end

    def ref(options)
      options[:ref] ? options[:ref] : 'latest'
    end
end
