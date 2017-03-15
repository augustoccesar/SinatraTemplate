require 'rubygems'
require 'bundler'
require 'yaml'
require 'json'
Bundler.require(:default)

ROOT = "#{File.expand_path(File.dirname(__FILE__))}/lib"
ENVIRONMENT = Sinatra::Base.environment.to_s

require "#{ROOT}/config/config_loader.rb"

Dir.glob("#{ROOT}/modules/**/{models,helpers,controllers}/*.rb").each do |file|
  require file
  print "Loaded #{file.split('/')[-4..-1].join('/')} \n"
end

Dir.glob("#{ROOT}/modules/**/*_controller.rb").each do |tst|
  module_name = tst.split('/')[-3]
  controller_name = tst.split('/')[-1].scan(/(\w+)_controller.rb/)[0][0]

  if controller_name.include?('_')
    class_name = controller_name.split('_').map {|w| w.capitalize }.join('')
  else
    class_name = controller_name.capitalize
  end

  map("/#{module_name}/#{controller_name}") { run Module.const_get("#{class_name}Controller") }
end

