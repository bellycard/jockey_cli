class Deploy < ThorCli
  namespace 'restart'
  default_task :restart

  desc 'restart', 'Restart containers'
  option :worker, type: :string
  option :only_failing, type: :boolean
  def restart
    params = { app: app, environment: environment }
    params.merge!(worker: options[:worker]) if options[:worker]
    params.merge!(healthy: false) if options[:only_failing]

    response = JockeyCli::Worker.restart(params)
    worker = response.data

    if worker
      say("Restarted #{app} on #{environment}", :green)
    else
      say(response.error.message, :red)
    end
  end
end