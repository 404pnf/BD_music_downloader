# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
doc = Nokogiri::HTML open(ARGV[0])
doc.css('span.song-title a').each do |link|
  file_name = link.attributes['title'].value
  path = link.attributes['href'].value
  download_page = Nokogiri::HTML open("http://music.baidu.com#{path}/download")
  download_button = download_page.css 'a#download'
  file_path = download_button[0].attributes['href'].value
  Thread.new do
  `wget -O "#{file_name}".mp3 http://music.baidu.com#{file_path}`
  end
end
