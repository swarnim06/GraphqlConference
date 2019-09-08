#!/bin/bash
echo "Reading config...."
. graphql.cfg #note the space between the dot and the leading slash of /etc.cfg
#source graphql.cfg
status_code=$(curl --write-out %{http_code} \
 --request POST \
 --header "Content-Type:application/json" \
 --header "X-Hasura-Role:$graphql_role" \
 --header "X-Hasura-Access-Key:$graphql_secret_key" \
 -d @track_tables.json \
 --url $graphql_api \
 -so "track_tables.log" \
 --noproxy "*")

if [[ "$status_code" == 200 ]] ; then
  echo "Successfully imported all tables in public schema to GraphQL-Engine"
else
  echo "Error while importing tables in public schema into GraphQL-Engine"
  echo "Please refer to log file track_tables.log!"
fi

status_code=$(curl --write-out %{http_code} \
 --request POST \
 --header "Content-Type:application/json" \
 --header "X-Hasura-Role:$graphql_role" \
 --header "X-Hasura-Access-Key:$graphql_secret_key" \
 -d @track_relations.json \
 --url $graphql_api \
 -so "track_relations.log" \
 --noproxy "*")

if [[ "$status_code" == 200 ]] ; then
  echo "Successfully imported all relations in public schema to GraphQL-Engine"
else
  echo "Error while importing all relations in public schema into GraphQL-Engine"
   echo "Please refer to log file track_relations.log!"
fi
