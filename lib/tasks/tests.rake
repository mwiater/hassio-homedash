namespace :tests do

  desc 'run spec tests'
  task :run, [:testName] do |t, args|
    if !args.testName.nil? and !args.testName.empty?
      system("bundle exec rspec ./spec/#{args.testName}_spec.rb --format documentation")
    else
      system('bundle exec rspec --format documentation')
    end
  end
  task run: :before

end