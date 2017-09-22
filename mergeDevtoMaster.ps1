cd "C:\Users\stevenme\Documents\GitHub\armtemplates"
git checkout master
Write-Host
git merge dev
Write-Host
git push origin master
Write-Host
git checkout dev
Write-Host "`nDone...`n" -ForegroundColor Green
Read-Host "Press Enter to exit" | Out-String