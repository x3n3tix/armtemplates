cd "C:\Users\stevenme\Documents\GitHub\armtemplates"
git add -A
Write-Host "`n$(git status | Out-String)" -ForegroundColor Cyan
if ((git status | Out-String) -ilike "*Changes to be committed*"){
    $message = Read-Host "Enter a commit message"
    Write-Host "`n$(git commit -m $message -v | Out-String)" -ForegroundColor Yellow
    Write-Host "`n$(git push -v | Out-String)" -ForegroundColor Cyan
    Write-Host "`nDone..." -ForegroundColor Green
}
Read-Host "Press Enter to exit" | Out-String