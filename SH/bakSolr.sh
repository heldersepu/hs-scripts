echo ""
echo "CREATE SOLR BAK"

rm -r -I ~/bakSolr
mkdir ~/bakSolr
cp /solr/*.* ~/bakSolr
mkdir ~/bakSolr/data

echo " ... BAK core status"
mkdir ~/bakSolr/cores
mkdir ~/bakSolr/cores/status
mkdir ~/bakSolr/cores/status/data
mkdir ~/bakSolr/cores/status/conf
cp -r /solr/cores/status/conf ~/bakSolr/cores/status

echo " ... BAK core remaxoffice"
mkdir ~/bakSolr/cores/remaxoffice
mkdir ~/bakSolr/cores/remaxoffice/data
mkdir ~/bakSolr/cores/remaxoffice/conf
cp -r /solr/cores/remaxoffice/conf ~/bakSolr/cores/remaxoffice

echo " ... BAK core remaxlistings"
mkdir ~/bakSolr/cores/remaxlistings
mkdir ~/bakSolr/cores/remaxlistings/data
mkdir ~/bakSolr/cores/remaxlistings/conf
cp -r /solr/cores/remaxlistings/conf ~/bakSolr/cores/remaxlistings

echo " ... BAK core remaxagent"
mkdir ~/bakSolr/cores/remaxagent
mkdir ~/bakSolr/cores/remaxagent/data
mkdir ~/bakSolr/cores/remaxagent/conf
cp -r /solr/cores/remaxagent/conf ~/bakSolr/cores/remaxagent

echo " ... BAK core listings"
mkdir ~/bakSolr/cores/listings
mkdir ~/bakSolr/cores/listings/data
mkdir ~/bakSolr/cores/listings/conf
cp -r /solr/cores/listings/conf ~/bakSolr/cores/listings

mkdir ~/bakSolr/conf
cp -r /solr/conf ~/bakSolr

echo "SOLR BAK CREATED"
echo ""
