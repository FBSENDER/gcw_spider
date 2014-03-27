module SpiderGcw
	class SongSpider
		def initialize
			@song_home = 'http://www.gcwzj.com/wuqu/'
		end
		def get_songs
			page = Nokogiri::HTML HTTParty.get(@song_home)
			page.css("li[class='area']").each do |area|
				song_area = area.css("span[class='title']").text
				area.css("a[class='wuqu1']").each do |a|
					next if GcwSong.exists?(:song_name => a.text)
					gcw_song = GcwSong.new
					gcw_song.song_name = a.text
					gcw_song.song_href = a.attributes["href"].value
					gcw_song.song_area = song_area
				  gcw_song.save
				end
				puts "done #{song_area}"
			end
		end
	end
end

