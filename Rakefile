require File.expand_path('../config/application', __FILE__)
require 'rake'

Site::Application.load_tasks

namespace :deploy do
  USER    = 'makakilo'.freeze
  HOST    = 'li231-78.members.linode.com'.freeze
  PATH    = '/var/webapps/Makakilo-Elementary'.freeze
  GIT_URL = 'git@github.com:delonnewman/Makakilo-Elementary.git'.freeze
  DB_CONF = 'config/database.yml'.freeze
  SSH_KEY = "#{ENV['HOME']}/.ssh/id_rsa.pub".freeze
  PKGS    = 'libmysqlclient-dev libsqlite3-dev libmagickcore-dev'.freeze # Debian / Ubuntu Packages
  HTTPD_CONF = 'config/apache.conf'.freeze

  desc "launch SSH on #{HOST}"
  task :shell do
    sh "ssh -t #{USER}@#{HOST}"
  end

  desc "setup for deployment on #{HOST}"
  task :setup => :virtual_host do
    cmds = %{
      git clone #{GIT_URL} #{PATH} --depth 1
      cd #{PATH} &&
      sudo apt-get install #{PKGS} &&
      bundle install --deployment
      sudo /etc/init.d/apache2 restart
    }

    sh "ssh -t #{USER}@#{HOST} '#{cmds}'"
    sh "scp #{USER}@#{HOST}:#{PATH}/config/database.yml #{DB_CONF}" 
    sh "ssh -t #{USER}@#{HOST} 'cd #{PATH} && rake db:setup RAILS_ENV=production'"
  end

  task :virtual_host do
    file      = HTTPD_CONF.split('/').last
    enabled   = "/etc/apache2/sites-enabled/#{HOST}"
    available = "/etc/apache2/sites-available/#{HOST}"

    cmds = %{
      cd ~ &&
      sudo cp #{file} #{available}
      sudo rm #{enabled}
      sudo ln -s #{available} #{enabled}
    }

    sh "scp #{HTTPD_CONF} #{USER}@#{HOST}:~"
    sh "ssh -t #{USER}@#{HOST} '#{cmds}'"
  end

  desc "remove deployment on #{HOST}"
  task :remove do
    sh "ssh -t #{USER}@#{HOST} 'rm -rf #{PATH}'"
  end

  desc "export SSH key to #{HOST}"
  task :export_key do
    file = SSH_KEY.split('/').last

    cmds = %{
      cd ~ &&
      perl -e 'mkdir "$ENV{HOME}/.ssh" unless -e "$ENV{HOME}/.ssh"' &&
      cat #{file} >> $HOME/.ssh/authorized_keys
    }

    sh "scp #{SSH_KEY} #{USER}@#{HOST}:~"
    sh "ssh -t #{USER}@#{HOST} '#{cmds}'"
  end

  desc "deploy to #{HOST}"
  task :live do
    cmds = %{
      cd #{PATH} &&
      git pull &&
      bundle install --deployment &&
      rake db:migrate RAILS_ENV=production
      touch #{PATH}/tmp/restart.txt
    }

    sh "git push && ssh -t #{USER}@#{HOST} '#{cmds}'"
  end
end

namespace :db do
  desc "dump data to db/dump.sql"
  task :dump do
    require 'yaml'
    config = YAML.load_file(DB_CONF)
    db     = config[ENV['RAILS_ENV'] || 'development']
    host   = db['host']
    user   = db['username']
    passwd = db['password']
    schema = db['database']

    sh "mysqldump -u #{user} --password=#{passwd} -h #{host} #{schema} > db/dump.sql"
  end
end
