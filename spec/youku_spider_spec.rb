require 'spec_helper'

spider = SpiderGcw::YoukuSpider.new("陶菲克","http://www.soku.com/search_video/q_%E9%99%B6%E8%8F%B2%E5%85%8B_orderby_3_lengthtype_4?sfilter=1&noqc=")
spider.get_video