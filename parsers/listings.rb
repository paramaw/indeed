nokogiri = Nokogiri::HTML(content)

SITE_URL = "https://www.indeed.com".freeze

jobs = nokogiri.xpath('//a[contains(@class, "jobtitle")]')

jobs.each do |job|
	link = job.xpath('./@href')&.text
	
	url = SITE_URL + link

	if url =~ /\Ahttps?:\/\//i
		pages << {
			url: url,
			page_type: 'jobs',
			fetch_type: 'browser',
			force_fetch: true,
			vars: {
				url: url,
			}
		}
	end
end

pagination = nokogiri.xpath('//div[@class="pagination"]/a/@href')
pagination.each do |page|
	url = SITE_URL + page.text
	pages << {
		url: url,
		page_type: 'listings',
		force_fetch: true,
		vars: {
			source: url
		}
	}
end