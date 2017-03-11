$errorDefaultAction="continue"
$source = "\\server\share"
$destination = "\\server\share"
$date = Get-Date -format M
$logFile = "D:\logs\\$CRL-Copy_log.txt"


Get-Date | Out-File $logFile -Append
echo "SOURCE IS:$source" | Out-File $logFile -Append
Get-ChildItem $source | Measure-Object -property length -sum | echo | Out-File $logFile -Append
echo "COPY JOB STARTED" | Out-File $logFile -Append
echo "           " | Out-File $logFile -Append

Get-ChildItem $source -Recurse | ForEach-Object {
  Try
    {
      $filePath = $_.fullname
      Copy-Item $filePath -Destination $destination -force
      $filePath | Out-File $logFile -Append
    }
  Catch
    {
      echo "error moving $filePath" | Out-File $logFile -Append
    }
}

echo "           " | Out-File $logFile -Append
echo "           " | Out-File $logFile -Append
echo "COPY JOB FINISHED" | Out-File $logFile -Append
echo "           " | Out-File $logFile -Append
echo "DESTINATION IS:$destination" | Out-File $logFile -Append
Get-ChildItem $destination | Measure-Object -property length -sum | echo | Out-File $logFile -Append
Get-Date | Out-File $logFile -Append
