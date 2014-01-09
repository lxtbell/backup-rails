# encoding: utf-8
require 'dotenv'
require "rails"

##
# Backup Generated: general
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t general [-c <path_to_configuration_file>]
#
Backup::Model.new(:general, 'Description for general') do
  Dotenv.load

  root_path = File.dirname(__FILE__)
  archive :code do |archive|
    archive.root root_path
    archive.add "."
    archive.exclude root_path + '/log'
    archive.exclude root_path + '/tmp'
  end

  compress_with Gzip do

  end

  if ENV['SSL_PASSWORD']
    encrypt_with OpenSSL do |encryption|
      encryption.password = ENV['SSL_PASSWORD']
      encryption.base64   = true
      encryption.salt     = true
    end
  end

  if File.exists? root_path + "/config/database.yml"
    environment = 'production'
    dbconfig = YAML::load(ERB.new(IO.read(File.join(root_path, 'config', 'database.yml'))).result)[environment]
    if dbconfig['adapter'] == 'mysql2'
      database MySQL do |db|
        db.name               = dbconfig['database']
        db.username           = dbconfig['username']
        db.password           = dbconfig['password']
        db.host               = dbconfig['host']
        db.port               = dbconfig['port']
        db.socket             = dbconfig['socket']
      end
    end
  end

  if File.exists? root_path + "/config/mongoid.yml"
    environment = 'production'
    dbconfig = YAML::load(ERB.new(IO.read(File.join(root_path, 'config', 'mongoid.yml'))).result)[environment]
    if dbconfig
      database MongoDB do |db|
        db.name               = dbconfig['sessions']['default']['database']
        db.username           = dbconfig['sessions']['default']['username']
        db.password           = dbconfig['sessions']['default']['password']
        #db.host               = dbconfig['host']
        #db.port               = dbconfig['port']
        db.ipv6               = false
        db.lock               = false
        db.oplog              = false
      end
    end
  end

  if ENV['LOCAL_PATH']
    store_with Local do |local|
      local.path = ENV['LOCAL_PATH']
      local.keep = 5
    end
  end


end
