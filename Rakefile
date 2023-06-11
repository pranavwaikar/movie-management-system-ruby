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
