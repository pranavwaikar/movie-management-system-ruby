# frozen_string_literal: true

task :lint do
  system('bundle exec rubocop  -A')
end

task :test do
  system('RAILS_ENV=test bundle exec rspec spec/**.rb')
end

task :start do
  system('ruby index.rb')
end
