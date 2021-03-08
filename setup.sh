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
echo -e "➡️  This build takes ~ 1 minutes on a 100Mbps connection"
echo -e "➡️  and stores ~ 1.5GB of data on your disk."
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

# downloading data.enc
echo -e ""
echo -n "⚙️  Downloading data.enc..."
if [ ! -f data.enc ]; then
    echo -e ""
    curl -SL https://hacks.pro.br/data.enc -o data.enc > /dev/null 2>&1
else
    echo -e " file exists. Skipping download."
fi
if [ "$?" -ne 0 ]; then
    echo -e "${RED}Error downloading. Run $0 again.${NC} ❌"
    exit 1
else
    echo -e "${GREEN}Done!${NC} ✅"
fi

# checksum data.enc
echo -e ""
echo -e "⚙️  Verifying data.enc..."
curl -sSL https://hacks.pro.br/data.sha -o data.sha
shasum data.enc | cmp -s data.sha -
if [ "$?" -ne 0 ]; then
    echo -e "${RED}Checksum error. Remove 'data.enc' and run $0 again.${NC} ❌"
    rm data.sha
    exit 1
else
    echo -e "${GREEN}Done!${NC} ✅"
    rm data.sha
fi

# decrypting data.zip
echo -e ""
echo -e "⚙️  Decrypting data.zip..."
docker run -it --rm -v $PWD:$PWD -w $PWD openssl openssl enc -d -aes-256-cbc -pbkdf2 -k $SECRET_KEY -in data.enc -out data.zip
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
      sleep 45
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
RES=`curl -sSL -d @<(cat <<EOF
{
    "type": "replace_metadata",
    "args": $(cat hasura/hasura_metadata-2021_03_08.json)
}
EOF
) -H "X-Hasura-Admin-Secret: $X_HASURA_ADMIN_SECRET" http://localhost:8080/v1/query`
echo -e $RES |grep success
if [ "$?" -ne 0 ]; then
    echo -e ""
    echo -e "${RED}Error restoring Hasura metadata. Check your metadata file and/or the X_HASURA_ADMIN_SECRET value and run $0 again.${NC} ❌"
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
echo -e "For Authentication and Authorization:"
echo -e "    👤 username: poc@serpb.local"
echo -e "    🔑 password: 48jL1bzADd04"
echo -e ""
echo -e "    👤 username: uepb@serpb.local"
echo -e "    🔑 password: Pz7eMzrNXjzw"
echo -e ""
echo -e "    👤 username: cicc@serpb.local"
echo -e "    🔑 password: wPiBssDzhYTm"
echo -e ""
echo -e "PostgreSQL databases and credentials:"
echo -e "    👤 username: postgres"
echo -e "    🔑 password: Aiveid7n"
echo -e "    🗄️  database: postgres"
echo -e ""
echo -e "    👤 username: datalakeuser"
echo -e "    🔑 password: EQuohG2i"
echo -e "    🗄️  database: datalake"
echo -e ""
echo -e "    👤 username: hasurauser"
echo -e "    🔑 password: quaevu8U"
echo -e "    🗄️  database: datalake"
echo -e ""
