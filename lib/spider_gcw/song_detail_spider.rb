module SpiderGcw
	class SongDetailSpider
		def initialize
			@home = "http://www.gcwzj.com"
		end
		def get_song_details
			GcwSong.all.to_a.each do |song|
				page =  Nokogiri::HTML HTTParty.get(song.song_href)
				page.css("div[class='mdBoxBd']").each do |box|
					box.css("li").each do |li|
						begin 
							gcw_video = GcwVideo.new 
							href = li.css("a").first.attributes["href"].value
							img_href = li.css("img").first.attributes["src"].value
							video_name = li.css("img").first.attributes["alt"].value
							next if GcwVideo.exists?(:video_name => video_name)

							detail_page = Nokogiri::HTML HTTParty.get(@home + href)
							scripts = detail_page.css("div[class='like_play']").first.css("script").to_s
							gcw_video.video_href = /http.*swf/.match(scripts).to_s
							gcw_video.video_img = @home + img_href
							gcw_video.video_name = video_name
							gcw_video.gcw_song_id = song.id
							gcw_video.save
						rescue Exception => ex 
							puts ex
							next
						end
					end
				end
			end
		end
	end
end

