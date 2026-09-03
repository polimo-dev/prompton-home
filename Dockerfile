# prompton-home — static landing page behind nginx.
#   docker build --build-arg APP_URL=https://app.dev.prompton.ai --build-arg HOME_URL=https://dev.prompton.ai -t prompton-home:dev-local .
FROM alpine:3.20 AS build
ARG APP_URL=https://app.prompton.ai
ARG HOME_URL=https://prompton.ai
ARG DOCS_URL=https://docs.prompton.ai
WORKDIR /src
COPY site site
COPY build.sh .
RUN APP_URL="$APP_URL" HOME_URL="$HOME_URL" DOCS_URL="$DOCS_URL" ./build.sh

FROM nginx:1.27-alpine
ARG APP_URL=https://app.prompton.ai
ARG DOCS_URL=https://docs.prompton.ai
ENV APP_URL=$APP_URL DOCS_URL=$DOCS_URL
COPY nginx/default.conf.template /etc/nginx/templates/default.conf.template
COPY --from=build /src/dist /usr/share/nginx/html
EXPOSE 8080
