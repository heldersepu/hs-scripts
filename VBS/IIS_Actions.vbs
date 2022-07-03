
ServerList = "web01,web02,web03,web04,web05,web06,web07,web08,web09,web10"

For Each server In Split(ServerList, ",")
    'Take server offline & wait a few
    'iisreset

    Set oIIS = GetObject("winmgmts:\\" + server + "\root\WebAdministration")
    Set oSite = oIIS.Get("Site.Name='RemaxWesternCanadaMobile'")
    'oSite.DoSomething...

    'iisreset
    'warm up server
    'Bring back online
Next

msgBox "All Done"
