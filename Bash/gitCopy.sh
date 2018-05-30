
#!/bin/sh
# copy full git repo to new location

echo ""
echo "This script will copy all the files from git repositories"
echo ""
read -p "Press enter to continue "


git clone --mirror {<url to ORI repo> temp-dir

git tag
git branch -a

echo ""
echo "Make sure all the tags and branches are listed..."
echo ""
read -p "Press enter to continue "

# clear the link to the ORI repository
git remote rm origin

# link your local repository to your new one
git remote add origin <url to NEW repo>

git push origin --all
git push --tags
