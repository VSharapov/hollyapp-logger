#!/bin/bash

listID=$1

cookieFile="${listID}.cookie"

if [ ! -f $cookieFile ]; then
  token="$(curl -L -b ${cookieFile} -c ${cookieFile} https://hollyapp.com/n/${listID} 2>/dev/null | grep "csrf-token" | cut -d'"' -f2)"
  curl -L -b ${cookieFile} -c ${cookieFile} --data "_method=put&authenticity_token=$token" https://hollyapp.com/privacy_policy/accept >/dev/null 2>/dev/null
fi
curl -L -b ${cookieFile} -c ${cookieFile} https://hollyapp.com/n/${listID} 2>/dev/null
