class Scale < ThorCli
  namespace 'scale'
  default_task :get

  desc 'set', 'Set the scale settings for an app'
  def set(worker, scale)
    response = JockeyCli::Worker.filter(app: app,
                                        environment: environment,
                                        worker: worker)

    if response.data.count == 0
      say("Error: Worker not found \"#{worker}\"", :red)
    else
      set_response = JockeyCli::Worker.update(response.data.first.id, scale: scale)
      if set_response.data
        say "Setting #{app}:#{worker} scale = #{set_response.data.scale}", :green

        response = JockeyCli::Worker.filter(app: app, environment: environment)
        workers = response.data
        render_worker_table(workers)
      end
    end
  end

  desc 'get', 'Get the scale settings for an app'
  option :verbose, type: :boolean
  def get
    response = JockeyCli::Worker.filter(app: app, environment: environment)
    workers = response.data

    if workers
      if options[:verbose]
        render_deploys_table(workers)
      else
        render_worker_table(workers)
      end
    else
      say("Error: Worker not found for #{app}/#{environment}", :red)
    end
  end

  private
    def render_worker_table(workers)
      table = [%w(Name Scale Command)]

      workers.each do |worker|
        table << [
          worker.name,
          worker.scale,
          worker.command
        ]
      end

      print_table table
    end

    def render_deploys_table(workers)
      table = [%w(Name Tag Hostname Address Port)]

      workers.each do |worker|
        deploys = JockeyCli::Worker.deploys(worker.id)
        if deploys.data.instances.any?
          deploys.data.instances.each do |node|
            if node
              table << [
                node.service.id,
                node.tags.select{|t| t.start_with?('rref:')}.first.slice(0,13),
                node.node.id,
                node.node.address,
                node.port
              ]
            end
          end
        end
      end

      print_table table
    end
end
