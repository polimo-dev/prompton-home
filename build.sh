#!/bin/sh
# Renders site/ into dist/ with the environment's URLs baked in.
#   APP_URL=https://app.dev.prompton.ai HOME_URL=https://dev.prompton.ai ./build.sh
set -eu
: "${APP_URL:=https://app.prompton.ai}"
: "${HOME_URL:=https://prompton.ai}"
: "${DOCS_URL:=https://docs.prompton.ai}"
rm -rf dist && mkdir -p dist
for f in site/*; do
  case "$f" in
    *.html|*.txt|*.sh) sed -e "s#__APP_URL__#${APP_URL}#g" -e "s#__HOME_URL__#${HOME_URL}#g" -e "s#__DOCS_URL__#${DOCS_URL}#g" "$f" > "dist/$(basename "$f")" ;;
    *) cp "$f" "dist/$(basename "$f")" ;;
  esac
done
echo "dist/ rendered for APP_URL=${APP_URL} HOME_URL=${HOME_URL} DOCS_URL=${DOCS_URL}"
