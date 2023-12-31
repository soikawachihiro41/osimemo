# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.3'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
# gem "pg", "~> 1.1"
# gem "sqlite3"
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'
gem 'meta-tags'
# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'rails-i18n'

# API
gem 'line-bot-api'

# 画像合成用
gem 'mini_magick'
# ファイルのアップロード機能
gem 'carrierwave', '~> 1.3'
gem 'cloudinary', '~> 1.16'

# 画像メモリ対策
gem 'posix-spawn'
# AWS S3
gem 'fog-aws'
# AWS確認用
gem 'aws-sdk-s3'
# 検索機能追加
gem 'ransack'
# 環境変数を管理する
gem 'dotenv-rails'
gem 'gon'

# バックグラウンド
gem 'byebug'
# 管理者画面
gem 'activeadmin'
gem 'devise'
gem 'sassc'

# Use Sass to process CSS
# gem "sassc-rails"
gem 'tailwindcss-rails'
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
gem 'cssbundling-rails'
group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'sqlite3'
  gem 'web-console'
  # 構文チェック
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-rails', require: false
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"
end
# Speed up commands on slow machines / big apps [https://github.com/rails/spring]
# gem "spring"
group :production do
  gem 'pg'
end

gem 'dockerfile-rails', '>= 1.5', group: :development

gem 'sentry-ruby', '~> 5.10'

gem 'sentry-rails', '~> 5.10'
