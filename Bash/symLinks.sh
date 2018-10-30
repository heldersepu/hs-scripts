
declare -a arr=(
    "y-commerce/dataanalyticsaddon"
    "y-commerce/data/datacockpits"
    "y-commerce/data/datacore"
    "y-commerce/data/datafacades"
    "y-commerce/data/datafulfilmentprocess"
    "y-commerce/data/datainitialdata"
    "y-commerce/dataintegration"
    "y-commerce/datapromotions"
    "y-commerce/data/datastorefront"
    "y-commerce/data/datatest"
    "y-commerce/paymetric"
    )

cd "~/code/HYBRISCOMM6500P_14-80003045/hybris/bin/custom"
for i in "${arr[@]}"
do
    echo "${i}"
    ln -s "../../../../${i}" "${i##*/}"
done

