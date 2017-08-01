
YAML_INPUT_FILE=".config.yml"
eval "$(./scripts/yaml.sh ${YAML_INPUT_FILE} config_)"

for i in $(seq 0 ${#config_sites[@]}); do
  site=${config_sites[$i]}
  arr=(${site/|/ })

  domain=${arr[0]}
  publicPath=${arr[1]}

  if [ ${#site} != 0 ]; then
    sh ./apache2/create_conf.sh $domain $publicPath
  fi
done

for i in $(seq 0 ${#config_databases[@]}); do
  database=${config_databases[$i]}

  if [ ${#database} != 0 ]; then
    sh ./mysql/create_sql.sh $database
  fi
done
