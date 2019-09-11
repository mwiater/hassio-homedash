namespace :app do

  desc 'Run application in DEVELOPMENT mode'
  task :runDevelopment do
    system('/bin/bash', '-c', "ENVIRONMENT=development bundle exec pumactl -F ./config/puma.rb start")
  end
  task runDevelopment: :before

  desc 'Run application in PRODUCTION mode'
  task :runProduction do
    system('/bin/bash', '-c', "ENVIRONMENT=production bundle exec pumactl -F ./config/puma.rb start")
  end
  task runProduction: :before

  desc 'Puma: Add Worker'
  task :addWorker do
    `kill -TTIN $(ps aux | grep '[p]uma.sock' | awk '{print $2}')`
  end
  task addWorker: :before

  desc 'Puma: Remove Worker'
  task :removeWorker do
    `kill -TTOU $(ps aux | grep '[p]uma.sock' | awk '{print $2}')`
  end
  task removeWorker: :before

  desc 'Puma: Current Worker Count'
  task :currentWorkerCount do
    pumaStats = JSON.parse(`bundle exec pumactl -S ./tmp/pids/puma.state stats`.gsub("Command stats sent success\n", "").gsub("\n", ""))

    puts pumaStats["workers"]
  end
  task currentWorkerCount: :before

  desc 'Puma Stats'
  task :pumaStats do
    pumaStats = JSON.parse(`bundle exec pumactl -S ./tmp/pids/puma.state stats`.gsub("Command stats sent success\n", "").gsub("\n", ""))

    ap pumaStats
  end
  task pumaStats: :before

  desc 'Puma Garbage Collesction Stats'
  task :pumaGCStats do
    pumaGCStats = JSON.parse(`bundle exec pumactl -S ./tmp/pids/puma.state gc-stats`.gsub("Command gc-stats sent success\n", "").gsub("\n", ""))

    ap pumaGCStats
  end
  task pumaGCStats: :before

  desc 'processes'
  task :processes do
    # AB Test Load: ab -n 10000 -c 100 http://mjw-vm-ruby:3000/api
    rakePID       = `ps aux | grep '[a]pp:run' | awk '{print $2}'`.strip
    pumaLaunchPID = `ps aux | grep '[b]undle exec puma' | awk '{print $2}'`.strip
    pumaPID       = YAML.load_file("#{ENV['PWD']}/tmp/pids/puma.state")["pid"]
    
    puts "App Processes:"
    puts "rakePID:       #{rakePID}"
    puts "pumaLaunchPID: #{pumaLaunchPID}"
    puts "pumaPID:       #{pumaPID}"
    puts "--------------------"

    puts `ps aux | grep "[:] #{pumaPID}" | awk '{print $2}'`

    exit
    
    rakePIDCPU = `top -sbn1 -p #{rakePID} | tail -n1 | awk '{print $9}'`.strip.to_f
    rakePIDMEM = `top -sbn1 -p #{rakePID} | tail -n1 | awk '{print $10}'`.strip.to_f

    pumaLaunchPIDCPU = `top -sbn1 -p #{pumaLaunchPID} | tail -n1 | awk '{print $9}'`.strip.to_f
    pumaLaunchPIDMEM = `top -sbn1 -p #{pumaLaunchPID} | tail -n1 | awk '{print $10}'`.strip.to_f

    pumaPIDCPU = `top -sbn1 -p #{pumaPID} | tail -n1 | awk '{print $9}'`.strip.to_f
    pumaPIDMEM = `top -sbn1 -p #{pumaPID} | tail -n1 | awk '{print $10}'`.strip.to_f

    appCPU = rakePIDCPU+pumaLaunchPIDCPU+pumaPIDCPU
    appMEM = rakePIDMEM+pumaLaunchPIDMEM+pumaPIDMEM

    puts "App CPU: #{appCPU}"
    puts "App MEM: #{appMEM}"
    puts ""

  end
  task processes: :before
  
end




