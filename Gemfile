source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.6'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'pry-rails'
gem 'sorcery'
gem 'cancancan', '2.1.0'
gem 'jbuilder', '~> 2.5'
gem 'kaminari'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
end
