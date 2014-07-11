::C:\mongo\mongoimport.exe --host ds035498.mongolab.com --port 35498 -u test -p abc123#  -d blog -c posts < posts.json

C:\Python27\python.exe validate.py -p ds035498.mongolab.com -m mongodb://test:abc123#@ds035498.mongolab.com:35498/blog -d blog

@echo.
@echo.
@pause
