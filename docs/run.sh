if [ -z "$JEKYLL_GITHUB_TOKEN" ]
then
    echo JEKYLL_GITHUB_TOKEN is empty
    echo See the readme for generating the token.  
else
    JEKYLL_GITHUB_TOKEN=$JEKYLL_GITHUB_TOKEN bundle exec jekyll serve --incremental
fi