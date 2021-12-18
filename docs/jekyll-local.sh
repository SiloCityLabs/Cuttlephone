docker run --rm \
  --volume="$PWD:/srv/jekyll" \
  --publish [::1]:8080:8080 \
  jekyll/jekyll:pages \
  jekyll serve \
  #--watch --drafts