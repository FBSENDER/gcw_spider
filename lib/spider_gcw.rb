require "mysql2"
require "active_record"
require "spider_gcw/version"
require 'httparty'
require 'nokogiri'
require 'open-uri'
require 'query'


ENV['GCW_ENV'] = 'development'
$dbconfig = {
	'development' => {
		:adapter => 'mysql2',
		:username => 'root',
		:password => 'Lmclinode0',
		:host => '127.0.0.1',
		:database => 'development_doit'
	},
	'production' => {
		:adapter => 'mysql2',
		:username => 'root',
		:password => '',
		:host => '127.0.0.1',
		:database => 'gcw'
	}
	
}

ActiveRecord::Base.establish_connection($dbconfig[ENV['GCW_ENV']])

require 'spider_gcw/gcw_db'
require 'spider_gcw/song_spider'
require 'spider_gcw/song_detail_spider'
require 'spider_gcw/youku_spider'
require 'spider_gcw/youku_detail_spider'
require 'spider_gcw/related_keywords_spider'
