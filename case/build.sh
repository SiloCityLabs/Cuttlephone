#! /bin/bash 

git_commit=$(git rev-parse --short HEAD)
for filepath in ./configs/*; do
    filename=$(basename -- "$filepath")
    filename="${filename%.*}"
    openscad -o build/"$filename".stl -D 'git_commit="'"$git_commit"'"' phone_case.scad
done