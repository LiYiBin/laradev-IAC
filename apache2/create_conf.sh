
relative=$1
domain=$2
sitePath=$3

defaultConf=$relative"default.apache.conf"
conf=$relative"sites/$domain.conf"
if [ -f $conf ]; then
  echo \"$conf\" already created!
  exit 0
fi

for i in $(seq 0 ${#sitePath}); do
  if [ "${sitePath:$i:1}" == "/" ]; then
    parsedPath=${parsedPath}\\${sitePath:$i:1}
  else
    parsedPath=${parsedPath}${sitePath:$i:1}
  fi
done

cp $defaultConf $conf

sed -i -e "s/{SERVER_NAME}/$domain/g" $conf
sed -i -e "s/{DOCUMENT_ROOT}/\/var\/www\/html\/$parsedPath/g" $conf
