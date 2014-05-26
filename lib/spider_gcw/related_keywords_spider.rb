module SpiderGcw
	class RelatedKeywordsSpider
		def get_related(keyword_string,current_level = 0)
			p keyword_string
			return if current_level > 3
			engine = Query::Engine::Baidu
			result = engine.query(keyword_string)
			related_keywords = result.related_keywords
			suggestions = engine.suggestions(keyword_string)
			kd = SpiderGcw::VideoRelatedKeyword.new
			kd.keyword_string = keyword_string
			kd.related_keywords = related_keywords.join(",")
			kd.suggestions = suggestions.join(",")
			kd.save unless SpiderGcw::VideoRelatedKeyword.exists?(:keyword_string => keyword_string)
			related_keywords.each do |wd|
				next if SpiderGcw::VideoRelatedKeyword.exists?(:keyword_string => wd)
				get_related(wd,current_level + 1)
			end
		end
	end
end