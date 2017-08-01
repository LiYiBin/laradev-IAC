
databaseName=$1

relative=$PWD"/mysql"
defaultSql=$relative"/createdb.sql.example"
sqlFile=$relative"/docker-entrypoint-initdb.d/create_$databaseName.sql"

if [ -f $sqlFile ]; then
  echo \"$sqlFile\" already created!
  exit 0
fi

cp $defaultSql $sqlFile

sed -i -e "s/{DATABASE_NAME}/$databaseName/g" $sqlFile
