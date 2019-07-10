FROM node:10.16.0-stretch

LABEL maintainer="Tobias Block <tobias@overscroll.com>" \
      org.label-schema.vendor="overscroll" \
      org.label-schema.name="strapi docker file" \
      org.label-schema.description="Strapi containerized" \
      org.label-schema.version=latest \
      org.label-schema.schema-version="1.0"

WORKDIR /usr/src/api

COPY ["strapi-app/package.json", "./strapi-app/"]
RUN echo "unsafe-perm = true" >> ~/.npmrc
RUN npm install -g strapi@beta 
RUN npm install --prefix ./strapi-app

COPY healthcheck.js ./

COPY strapi.sh ./
RUN chmod +x ./strapi.sh

RUN echo "yo" 
COPY ["strapi-app/api", "./strapi-app/api/"]
COPY ["strapi-app/config", "./strapi-app/config/"]
COPY ["strapi-app/extensions", "./strapi-app/extensions/"]
COPY ["strapi-app/public", "./strapi-app/public/"]

RUN ls -la ./strapi-app
RUN npm run build --prefix ./strapi-app
RUN NODE_ENV=production npm run build --prefix ./strapi-app

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s \
CMD node /usr/src/api/healthcheck.js
EXPOSE 1337


CMD ["./strapi.sh"]