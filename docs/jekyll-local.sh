docker run \
  -t --rm \
  -v "$PWD":/usr/src/app \
  -e JEKYLL_GITHUB_TOKEN=$JEKYLL_GITHUB_TOKEN \
  -p "4000:4000" starefossen/github-pages