#Polldaddy Screen Scraper v2.0
$datetime = Get-Date -format "yyyy/MM/dd HH:mm:ss"
#Just wrote a reminder here to avoide editing a LIVE file. Copy CSV before messing with it.
$scrapelog = "D:\NOLA\2017\ScrapeSample_DO_NOT_EDIT.csv"
$scrapesite = Invoke-WebRequest http://polls.polldaddy.com/vote-js.php?p=9679392
$scrapeArrayNames = $scrapesite.AllElements | Where Class -eq "pds-answer-text" | Select -First 20 -ExpandProperty innerText
$scrapeArrayVotes = $scrapesite.AllElements | Where Class -eq "pds-feedback-votes" | Select -First 20 -ExpandProperty innerText | ForEach {$_ -replace '(\D)'}
$scrapeCRUD = For ($i = 0; $i -le 19; $i++) {$scrapeArrayNames[$i] + "votes=" + $scrapeArrayVotes[$i]}
#Prepend Array with Date and time so this is all one file now.
$scrapeCSV = ,$datetime + $scrapeCRUD
$scrapeCSV -join "," | Out-File $scrapelog -Append
exit
