namespace :system do
  scope = Rake.application.current_scope

  desc "update: apt-get & apt update, upgrade, autoremove, autoclean, clean"
  task :update do
    puts "Testing rake task: ".green << "rake #{Rake.application.top_level_tasks[0]}\n\n"
    
    system('sudo apt-get update')
    system('sudo apt-get -y upgrade')
    system('sudo apt-get -y autoremove')
    system('sudo apt-get -y autoclean')
    system('sudo apt-get -y clean')

    system('sudo apt update')
    system('sudo apt -y upgrade')
    system('sudo apt -y autoremove')
    system('sudo apt -y autoclean')
    system('sudo apt -y clean')
  
  end
  task update: :before

  desc "Remove .DS_Store files and all other ._* files"
  task :clean do
    puts "Testing rake task: ".green << "rake #{Rake.application.top_level_tasks[0]}\n\n"
    
    system('find . -name ".DS_Store" -print0 | xargs -0 rm -rf && find . -name "._*" -print0 | xargs -0 rm -rf')
  end
  task clean: :before

end