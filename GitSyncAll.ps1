$oPath = (Get-Item -Path ".\" -Verbose).FullName

cd..
Get-ChildItem -Directory | foreach-object -process `
{ `
    echo .; `
    echo $_; `
    cd $_; `
    git pull; cd .. `
}

cd $oPath
