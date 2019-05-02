FROM strapi/strapi

LABEL maintainer="Tobias Block <tobias@overscroll.com>" \
      org.label-schema.vendor="overscroll" \
      org.label-schema.name="strapi docker file" \
      org.label-schema.description="Strapi containerized" \
      org.label-schema.version=latest \
      org.label-schema.schema-version="1.0"

WORKDIR /usr/src/api

COPY strapi-app /usr/src/api/strapi-app

RUN echo "unsafe-perm = true" >> ~/.npmrc

COPY strapi.sh ./
RUN chmod +x ./strapi.sh

CMD ["./strapi.sh"]