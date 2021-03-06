#!/bin/sh
set -ea

cd /usr/src/api

APP_NAME=${APP_NAME:-strapi-app}
DATABASE_CLIENT=${DATABASE_CLIENT:-mongo}
DATABASE_HOST=${DATABASE_HOST:-localhost}
DATABASE_PORT=${DATABASE_PORT:-27017}
DATABASE_NAME=${DATABASE_NAME:-strapi}
DATABASE_SRV=${DATABASE_SRV:-false}
EXTRA_ARGS=${EXTRA_ARGS:-}


cd $APP_NAME

if [ "$NODE_ENV" != "production" ]
  then 
    NODE_ENV=${NODE_ENV:-production} npm run develop
  else 
    NODE_ENV=${NODE_ENV:-production} npm run start &
fi

strapiPID=$!
wait "$strapiPID"