namespace :tunnel do
  desc 'Start tunnel'
  task :run do
    system('clear && lt --host http://0nezer0.com --port 3000 --subdomain sinboi')
  end
  task run: :before
end