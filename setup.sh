#!/bin/bash

# Setup SEFAZPB-DEV Hasura Environment
# Carlos Hacks - hacks@lavid.ufpb.br
# First Version: 2020-07-22

# colors
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'

X_HASURA_ADMIN_SECRET="7f561b9fb979122aacc6ea95311c4a6986d7088d360ca26db6b0b93ce613fa28"
SECRET_KEY="$1"

if [ "$#" -ne 1 ]; then
    echo -e "Usage: $0 <secret-key>"
    exit 1
fi

echo -e ""
echo -e "⚙️  SEFAZPB-DEV Environment Setup"
echo -e ""
echo -e "➡️  This build will take ~ 2 minutes in a 100Mbps connection"
echo -e "➡️  and it will take ~ 1.5GB of disk space."
echo -e ""

# building openssl image
echo -e "⚙️  Building OpenSSL Docker Image..."
docker build -t openssl ./openssl > /dev/null 2>&1
if [ "$?" -ne 0 ]; then
    echo -e "${RED}Error building image. Run $0 again.${NC} ❌"
    exit 1
else
    echo -e "${GREEN}Done!${NC} ✅"
fi

# decrypting data.zip
echo -e ""
echo -e "⚙️  Decrypting data.zip..."
docker run -it --rm -v $PWD:$PWD -w $PWD openssl openssl enc -d -aes-256-cbc -pbkdf2 -k $SECRET_KEY -in data.enc -out data.zip > /dev/null 2>&1
if [ "$?" -ne 0 ]; then
    echo -e "${RED}Error decrypting. Check the <secret-key> value and run $0 again.${NC} ❌"
    exit 1
else
    echo -e "${GREEN}Done!${NC} ✅"
fi

#  uncompressing data.zip (never commit it on GitHub)
echo -e ""
echo -e "⚙️  Uncompressing data.zip..."
unzip -o data.zip
if [ "$?" -ne 0 ]; then
    echo -e "${RED}Error uncompressing data.zip. Run $0 again.${NC} ❌"
    exit 1
else
    echo -e "${GREEN}Done!${NC} ✅"
fi

# deploying locally (can take a while! ~ 2GB)
echo -e ""
echo -e "⚙️  Starting environment with docker-compose..."
docker-compose up -d
if [ "$?" -ne 0 ]; then
    echo -e ""
    echo -e "${RED}Error deploying the environment. Run $0 again.${NC} ❌"
    exit 1
else
    echo -e "${GREEN}Done!${NC} ✅"
fi

echo -e ""
echo -e "⚙️  Wait a few seconds while Hasura Endpoint is being deployed..."
count=1
while true; do
   curl http://localhost:8080
   if [ "$?" -ne 0 ]; then
      sleep 15
   else
      break
   fi
   if [ $count -eq 5 ]; then
      echo -e ""
      echo -e "${RED}Timeout. Run $0 again.${NC} ❌"
      exit 1
   fi
   count=$(($count+1))
done

# restoring hasura metadata
echo -e "⚙️  Restoring hasura metadata..."
RES=`curl -sSL -d '{"type":"replace_metadata","args":'$(cat hasura/hasura_metadata-2020_07_22.json)'}' -H "X-Hasura-Admin-Secret: $X_HASURA_ADMIN_SECRET" http://localhost:8080/v1/query`
echo -e $RES |grep success
if [ "$?" -ne 0 ]; then
    echo -e ""
    echo -e "${RED}Error restoring Hasura metadata. Check the X_HASURA_ADMIN_SECRET value and run $0 again.${NC} ❌"
    exit 1
else
    echo -e "${GREEN}Done!${NC} ✅"
fi

echo -e ""
echo -e "💻 Your SEFAZPB-DEV Hasura Environment is finished! ✅"
echo -e ""
echo -e "Here is some information about your environment:"
echo -e "    🌐 hasura console: http://localhost:8080/console"
echo -e "    🌐 hasura endpoint: http://localhost:8080/v1/graphql"
echo -e "    🔑 x-hasura-admin-secret: $X_HASURA_ADMIN_SECRET"
echo -e ""
echo -e "For test Authentication and Authorization:"
echo -e "    👤 username: poc@serpb.local"
echo -e "    🔑 password: 48jL1bzADd04"
echo -e ""
