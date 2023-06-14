# frozen_string_literal: true

task :lint_fix do
  system('bundle exec rubocop  -a')
end

task :lint do
  system('bundle exec rubocop')
end

task :test do
  system('RAILS_ENV=test bundle exec rspec --pattern "./spec/**/*_test.rb" ')
end

task :start do
  system('ruby index.rb')
end

task :docker_test do
  system('docker-compose -f docker-compose-test.yml up --force-recreate --build --abort-on-container-exit')
end

task :docker_run do
  system('docker-compose -f docker-compose.yml up -d && docker-compose exec movie-booking-system bash')
end

task :docker_stop do
  system('docker kill movie-booking-system-ruby')
end
