# url = "https://www.indeed.com/rc/clk?jk=dcd418f5e22b6083&fccid=05d6cb8b919478a9&vjs=3"

# content = open url

nokogiri = Nokogiri::HTML content

title = nokogiri.xpath('//h3[contains(@class, "jobsearch-JobInfoHeader-title")]').text
company = nokogiri.xpath('///span[contains(@class, "jobsearch-JobInfoHeader-companyName")]').text
location = nokogiri.xpath('//div[contains(@class, "jobsearch-JobInfoHeader-companyLocation")]').text
job_description = nokogiri.xpath('//div[@id="jobDescriptionText"]').text
job_type = nokogiri.xpath('//p[contains(text(), "Job Type")]').text || ""
job_location = nokogiri.xpath('//p[contains(text(), "Location")]').text
scraped_at = Time.now.utc

job = {}

job['queryString'] = page['vars']['query']
job['title'] = title
job['company'] = company
job['location'] = location.empty? ? job_location : location
job['job_description'] = job_description
# job['job_type']　= job_type
job['scraped_at'] = scraped_at

job['_collection'] = "jobs"

outputs << job