namespace :utilities do
  scope = Rake.application.current_scope

  desc "sample"
  task :sample do
    puts "Testing rake task: ".green << "rake #{Rake.application.top_level_tasks[0]}\n\n"

  end
  task sample: :before

end