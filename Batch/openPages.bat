@set dPage=http://www.uat-remaxbeta.com/realestatehomesforsale/fl-p001.html#search/listingtypeid-104/bedrooms-0/bathrooms-0/sqftval-0/lotsizeval-0/ageofhomeval-0/sv-true/sortorder-pricehigh
:dStart

@START /b firefox %dPage%/pagenumber-1/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-2/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-3/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-4/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-5/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-6/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-7/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-8/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-9/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-10/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-11/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-12/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-13/tab-list/
ping 127.0.0.1 -n 2
@START /b firefox %dPage%/pagenumber-14/tab-list/

ping 127.0.0.1 -n 15
taskkill /im firefox.exe
ping 127.0.0.1 -n
goto dStart
