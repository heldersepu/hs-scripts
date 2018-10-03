# Script to speed up download of large files from S3 bucket

S3Uri="s3://backup/db/myhost/data/2018-10-02_0100__3_1.bak"
url=$(sudo aws s3 presign $S3Uri --expires-in 7000)
wget "$url" -O "${S3Uri##*/}"
