module SpiderGcw
	class YoukuSpider
		def initialize(list_name,href)
			@list_name = list_name
			@video_home = href
			puts @video_home
		end
		def get_video
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

