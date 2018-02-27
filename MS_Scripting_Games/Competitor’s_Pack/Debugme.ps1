for ($i in Get-ChildItem C:\Scripts)
(
    if {($i.CreationTime -gt ($(Get-Date).AddMonths(-10))) and ($i.Extension = "txt")}
    {
         Copy-Item $i.FullName C:\old
         $i.Name
         $x = $x + 1
    }
)

""
"Total Files: " + $y
