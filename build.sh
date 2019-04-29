#!/bin/sh

VERSION=$(grep versio version.json | sed -e "s/\"//g" | sed -e "s/version://g" | sed -e "s/ //g")

echo "Exisitng Version -- $VERSION"

to_increment=$(echo $VERSION |  rev | cut -d"." -f1  | rev)
rest_version=$(echo $VERSION |  rev | cut -d"." -f2-  | rev)

temp=$((to_increment+1))
next_version=$(echo "$rest_version.$temp")

echo "New Version -- $next_version"

sed "s/  \"version\":\"$VERSION\"/  \"version\":\"$next_version\"/g" version.json > _tmp_version.json

mv _tmp_version.json version.json

docker build --build-arg version=$next_version -f Dockerfile -t aiops-metricbeat . 
docker tag aiops-metricbeat:latest prabhuanand/aiops-metricbeat:latest
docker tag aiops-metricbeat:latest prabhuanand/aiops-metricbeat:$next_version

docker push prabhuanand/aiops-metricbeat:latest
docker push prabhuanand/aiops-metricbeat:$next_version