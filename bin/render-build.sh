#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
npm install -g npm@latest
rails assets:precompile
rails assets:clean
bundle exec rails db:migrate
bundle exec rails db:seed
