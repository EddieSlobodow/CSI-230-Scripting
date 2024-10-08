
$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://localhost/ToBeScraped.html

# Get a count of the links in the page
#$scraped_page.Links.count

#$scraped_page.Links

# Display only URL and its text

#$scraped_page.Links | select "outerText", "href" 

$h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2") | select outerText
#$h2s

$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
$_.getAttributeNode("class").Value -ilike "*div-1*"} | select innerText
$divs1