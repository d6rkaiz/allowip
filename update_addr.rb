#!/usr/bin/ruby
require 'rubygems'
require 'fcgi'
require 'geoip'

TARGET_FILE = '/etc/hosts.allow.d/update_addr'
GEOIPDAT_PATH = File.expand_path(File.dirname(__FILE__) + '/GeoIP.dat')
ALLOW_COUNTRY = ["JPN", "USA"]

FCGI.each_cgi do |cgi|
  puts cgi.header

  geo = GeoIP.new(GEOIPDAT_PATH).country(cgi.remote_addr)
  if ! ALLOW_COUNTRY.include? geo.country_code3
    puts "Sorry, Do not accept your country: #{geo.country_name}\n"
    next
  end

  begin
    File.open(TARGET_FILE,"w") do |f|
      f.puts "#{cgi.remote_addr}\n"
    end
  rescue
    puts "failed to open #{$!}"
  else
    puts "address updated to: #{cgi.remote_addr}\n"
  end
end
