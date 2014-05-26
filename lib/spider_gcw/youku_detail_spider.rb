module SpiderGcw
	class YoukuDetailSpider
		def video_sum_random
			SpiderGcw::Video.all.each do |video|
				max1 = Random.new.rand(100)
				p max1
				video.like_sum = Random.new.rand(max1 + 1)
				video.pv_sum = video.like_sum * 10 + max1
				p video.like_sum
				p video.pv_sum
				video.save
			end
		end
		def get_video_detail
			videos = SpiderGcw::Video.all 
			videos.each do |video|
				page = Nokogiri::HTML HTTParty.get(video.href)
				p page.at("span[id='videoTotalPV']")
				p page.at("div[class='comments']")
				break
			end
			exit 
			video_list = SpiderGcw::VideoList.where(:name => @list_name).first || SpiderGcw::VideoList.new
			video_list.name = @list_name
			video_list.href = @video_home
			video_list.save if video_list.id.nil? || video_list.id <= 0
			page = Nokogiri::HTML HTTParty.get(@video_home)
			sk_pager = page.at("div.sk_pager")
			xxx = sk_pager.css("li > a").map{|item| 'http://www.soku.com' + item["href"]}.uniq
			page.css("div.v").each do |v|
				img = v.at("div.v-thumb > img")
				link = v.at("div.v-link > a")
				
				video = SpiderGcw::Video.new
				video.img_href = img["src"]
				video.name = link["title"]
				video.href = link["href"]
				video.video_list_id = video_list.id 
				video.save unless SpiderGcw::Video.exists?(:name => video.name)
			end
			puts "#{@video_home} done"
			xxx.each do |video_list_link|
				page = Nokogiri::HTML HTTParty.get(video_list_link)
				page.css("div.v").each do |v|
					img = v.at("div.v-thumb > img")
					link = v.at("div.v-link > a")
					
					video = SpiderGcw::Video.new
					video.img_href = img["src"]
					video.name = link["title"]
					video.href = link["href"]
					video.video_list_id = video_list.id 
					video.save unless SpiderGcw::Video.exists?(:name => video.name)
				end
				puts "#{video_list_link} done"
			end
		end
	end
end

