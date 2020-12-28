#!/bin/bash

listID=$1

cookieFile="${listID}.cookie"

if [ ! -f $cookieFile ]; then
  token="$(curl -L -b ${cookieFile} -c ${cookieFile} https://hollyapp.com/n/${listID} 2>/dev/null | grep "csrf-token" | cut -d'"' -f2)"
  curl -L -b ${cookieFile} -c ${cookieFile} --data "_method=put&authenticity_token=$token" https://hollyapp.com/privacy_policy/accept >/dev/null 2>/dev/null
fi
responseHeaders=$(mktemp)
curl -L -b ${cookieFile} -c ${cookieFile} -D ${responseHeaders} https://hollyapp.com/n/${listID} 2>/dev/null >${listID}.todo
timeStamp=$(date --date="$(cat $responseHeaders | grep "^Date: " | cut -c7-)" -u +"%F %T")
if cat $responseHeaders | grep "Content-Type: text/html"; then
  >2 echo "\`curl https://hollyapp.com/n/${listID}\` got text/html instead of text/plain, probably an invalid id"
  rm ${listID}.todo
fi

echo $timeStamp > ${listID}.time
rm $responseHeaders


