
#!/bin/sh
# copy full git repo to new location
SOURCE='git@bitbucket.org:mycloud/old-platform.git'
DESTIN='git@bitbucket.org:mycloud/new.git'

RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m' # No Color

echo ""
echo "${RED}This script will copy all the files from git repositories!${NC}"
echo ""
read -p "Press enter to continue "


git clone --mirror ${SOURCE} temp-dir

cd temp-dir
git tag
git branch -a

echo ""
echo "${GRN}Make sure all the tags and branches are listed...${NC}"
echo ""
read -p "Press enter to continue "

# clear the link to the ORI repository
git remote rm origin

# link your local repository to your new one
git remote add origin ${DESTIN}

git push origin --all
git push --tags
