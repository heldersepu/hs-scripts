cd..
Get-ChildItem -Directory | foreach-object -process { echo .; echo $_; cd $_; git pull; cd ..}