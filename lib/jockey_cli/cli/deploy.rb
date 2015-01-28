class Deploy < ThorCli
  namespace 'deploy'
  default_task :deploy

  desc 'deploy', 'Deploy an app'
  option :interactive, aliases: [:i], type: :boolean
  option :raw_logs, aliases: [:raw], type: :boolean
  def deploy(rref = nil)
    # get the rref from the HEAD of the localy copy if not supplied
    if rref.nil?
      begin
        git = Git.open(Dir.pwd)
        rref = git.object('HEAD').sha
      rescue ArgumentError
        say "Unable to determine rref, exiting.", :red
        exit
      end
    end

    params = { app: app, environment: environment, rref: rref }
    response = JockeyCli::Deploy.create(params)
    deploy = response.data

    if deploy
      say("Deploying #{app} to #{environment}", :green)
      say("Deploy started for id:#{deploy.id}, rref:#{deploy.build.rref}, state:#{deploy.state}", :green)

      print_logs(deploy, options[:raw_logs]) if options[:interactive]
    else
      say(response.error.message, :red)
    end
  end

  desc 'logs', 'Deploy logs for an app'
  def logs(id=nil)
    if id
      deploy = JockeyCli::Deploy.find(options[:id]).data
    else
      deploy = JockeyCli::Deploy.filter(app: app, environment: environment).data.last
    end
    if deploy
      print_logs(deploy)
    else
      say("Can't find that deploy", :red)
    end
  end

  no_commands do
    def print_logs deploy, raw=false
      deploy_id = deploy.id
      build_id = deploy.build.id
      formatter = JockeyCli::LogFormatter.new raw: raw

      until %w(deployed failed).include?(deploy.state)
        deploy = JockeyCli::Deploy.find(deploy_id).data

        if deploy.state == 'building'
          formatter.logs = JockeyCli::Build.logs(build_id).logs
        else
          formatter.logs = JockeyCli::Deploy.logs(deploy_id).logs
        end
        formatter.print

        sleep(1)
      end
    end
  end
end
