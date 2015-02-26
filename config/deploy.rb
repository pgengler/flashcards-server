# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'flashcards-server'
set :repo_url, 'https://github.com/pgengler/flashcards-server.git'

set :deploy_to, '/srv/apps/flashcards/server'

set :linked_files, %w{ .env }
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'node_modules', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

namespace :deploy do
  after :publishing, :restart

  task :restart do
    on roles(:app) do
      invoke 'puma:restart'
    end
  end
end
