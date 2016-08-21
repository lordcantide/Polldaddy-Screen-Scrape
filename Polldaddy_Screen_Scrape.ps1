#Invoke-WebRequest http://polls.polldaddy.com/vote-js.php?p=9317003
#$ResultsPage = [io.file]::WriteAllBytes($tempfilename,(Invoke-WebRequest -URI "http://polls.polldaddy.com/vote-js.php?p=9317003").content)
$datetime = Get-Date -format "yyyyMMdd_HH.mm.ss"
$ShortTime = Get-Date -format "HH:mm"
$scrapelog = "D:\NOLA\Samples\scrape1a_" + $datetime + ".log"
$scrapesite = Invoke-WebRequest http://polls.polldaddy.com/vote-js.php?p=9317003
#$scrapesite.AllElements | Where {$_.innerText -match '(^2016 Big Idea '} | Out-File $scrapelog
#$scrapesite.AllElements | Out-File $scrapelog
$scrapeArrayNames = $scrapesite.AllElements | Where Class -eq "pds-answer-text" | Select -First 20 -ExpandProperty innerText
$scrapeArrayVotes = $scrapesite.AllElements | Where Class -eq "pds-feedback-votes" | Select -First 20 -ExpandProperty innerText | ForEach {$_ -replace '(\D)'}
$scrapeCRUD = For ($i = 0; $i -le 19; $i++) {$scrapeArrayNames[$i] + "votes=" + $scrapeArrayVotes[$i]}
"TimeCode: " + $datetime + "`r`n" + $ShortTime | Out-File $scrapelog
$scrapeCRUD | Out-File $scrapelog -Append
exit