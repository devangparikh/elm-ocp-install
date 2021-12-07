#!/bin/bash

if [[ -z "${JAZZ_TEAM_SERVER}" ]]; then
  echo "environment variable JAZZ_TEAM_SERVER must be set to run this script. It must point to JazzTeamServer directory"
  exit 1
fi

if [ ! -d "${JAZZ_TEAM_SERVER}" ] 
then
  echo "environment variable JAZZ_TEAM_SERVER must point to JazzTeamServer directory"
  exit 1
fi

SERVER_XML="${JAZZ_TEAM_SERVER}/server/liberty/clmServerTemplate/server.xml"

if [[ ! -f "${SERVER_XML}" ]]
then
  echo "environment variable JAZZ_TEAM_SERVER must point to JazzTeamServer directory"
  exit 1
fi

rm -rf copy
mkdir copy
cp -R ${JAZZ_TEAM_SERVER} ./copy/JazzTeamServer
sed -i 's/<keyStore id="defaultKeyStore".*/<keyStore id="defaultKeyStore" location="${keystore_pkcs12}" type="PKCS12" password="${keystore_pw}"\/>/g' ./copy/JazzTeamServer/server/liberty/clmServerTemplate/server.xml
mv ./copy/JazzTeamServer/server/conf ./copy/JazzTeamServer/server/confTemplate

docker build -t elm-ocp:latest -f ./docker/Dockerfile .
docker login -u ${REGISTRY_USERNAME} -p ${REGISTRY_PASSWORD} ${REGISTRY_URL}
docker tag elm-ocp:latest ${REGISTRY_URL}/elm-ocp:latest
docker push ${REGISTRY_URL}/elm-ocp:latest