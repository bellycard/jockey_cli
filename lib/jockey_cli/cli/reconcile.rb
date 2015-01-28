class Reconcile < ThorCli
  namespace 'reconcile'
  default_task :create

  desc 'create', 'Reconciles an app'
  option :preview, type: :boolean
  option :raw_logs, type: :boolean
  def create
    if options[:preview]
      response = JockeyCli::Reconcile.preview(app: app, environment: environment)
    else
      response = JockeyCli::Reconcile.create(app: app, environment: environment)
    end

    reconcile = response.data

    if reconcile.count == 0 # why count == 0?
      say "Error: Unable to reconcile \"#{app}\"", :red
    else
      if options[:preview]
        plan = response.data.plan.any? || 'nothing to do'
        say("Reconcile plan for #{app} on #{environment}: #{plan}", :green)

      else
        say("Started reconcile for #{app} on #{environment} with reconcile_id: #{response.data.id}", :green)

        print_logs(response.data, options[:raw_logs])
      end
    end
  end

  desc 'status', 'Get the status of a reconcile by id'
  def status(id)
    response = JockeyCli::Reconcile.find(id)
    reconcile = response.data

    if reconcile
      say("Reconcile status for id #{reconcile.id}: #{reconcile.state.upcase}", :green)
    else
      say(response.error.message, :red)
    end
  end

  no_commands do
    def print_logs reconcile, raw=false
      id = reconcile.id
      formatter = JockeyCli::LogFormatter.new raw: raw

      until %w(completed failed).include?(reconcile.state)
        reconcile = JockeyCli::Reconcile.find(id).data

        formatter.logs = JockeyCli::Reconcile.logs(id).logs
        formatter.print

        sleep(1)
      end
    end
  end
end
