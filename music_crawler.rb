require 'rubygems'
require 'mechanize'


puts "Crawling and downloading music from: #{ARGV.first}"

# probably should put a check here to exit the program if the link is invalid

YOUTUBE_REGEX = /(https?):\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/)([A-Za-z0-9_-]*)(\&\S+)?.*/
SOUNDCLOUD_REGEX = /(https?):\/\/soundcloud.com\//

a = Mechanize.new 

music_links = Array.new

a.get(ARGV.first) do |page|
  page.links.each do |link|
    if link.href =~ YOUTUBE_REGEX
      music_links << link.href 
    elsif link.href =~ SOUNDCLOUD_REGEX
      music_links << link.href
    end
  end  
end

music_links.uniq!

# File.open("chillwave_links.txt", 'w') do |file| 
#   music_links.each do |link|
#     file.write(link + " ")
#   end
# end

music_links.each do |link|
  p "Starting process: youtube-dl --audio-format mp3 #{link}..."
  output = `youtube-dl --audio-format mp3 #{link}`
  output.split(/\n|\r/).each do |line|
    p line
  end
end
