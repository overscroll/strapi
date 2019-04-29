FROM node:11.1.0-alpine

LABEL maintainer="Tobias Block <tobias@overscroll.com>" \
      org.label-schema.vendor="overscroll" \
      org.label-schema.name="strapi docker file" \
      org.label-schema.description="Strapi containerized" \
      org.label-schema.version=latest \
      org.label-schema.schema-version="1.0"

WORKDIR /usr/src/api

COPY strapi-app /usr/src/api/strapi-app

RUN echo "unsafe-perm = true" >> ~/.npmrc

RUN npm install -g strapi@alpha

COPY strapi.sh ./
RUN chmod +x ./strapi.sh

EXPOSE 1337

COPY healthcheck.js ./

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s \
      CMD node /usr/src/api/healthcheck.js

CMD ["./strapi.sh"]