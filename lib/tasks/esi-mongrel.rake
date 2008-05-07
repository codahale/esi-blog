namespace :esi do
  task :environment do 
    @log_file = File.expand_path(File.join(RAILS_ROOT, "log", "mongrel_esi.log"))
    @pid_file = File.expand_path(File.join(RAILS_ROOT, "tmp", "mongrel_esi.pid"))
  end
  
  desc "Start mongrel_esi with this app's configuration."
  task :start => :environment do
    run("mongrel_esi start --port 3001 --routes default:localhost:3000 --pid #{@pid_file} --log #{@log_file} --enable-for-surrogate-only --allowed-content-types text/html,application/xml,application/json,text/javascript -d")
  end
  
  desc "Stop mongrel_esi"
  task :stop => :environment do
    run("mongrel_esi stop -P #{@pid_file}")
  end
  
  def run(cmd)
    puts cmd
    system(cmd)
  end
  
end

