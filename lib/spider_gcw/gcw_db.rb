module SpiderGcw
	class GcwSong < ActiveRecord::Base
		# establish_connection $dbconfig[:development]
	end
	class GcwTeam < ActiveRecord::Base
		# establish_connection $dbconfig[:development]
	end
	class GcwVideo < ActiveRecord::Base
		# establish_connection $dbconfig[:development]
	end

	class Video < ActiveRecord::Base
	end
	class VideoList < ActiveRecord::Base
	end
	class VideoComment < ActiveRecord::Base
	end
	class VideoRelatedKeyword < ActiveRecord::Base
	end
end