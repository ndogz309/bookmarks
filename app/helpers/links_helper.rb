module LinksHelper

	def self.fix_url(url)
		if url[0...4] != 'http' && url[0...5] != 'https'
		  url = 'http://' + url
		end
		return url
	end
end
