#! /bin/bash 

git_commit=$(git rev-parse --short HEAD)
for filepath in ./configs/*; do
    filename=$(basename -- "$filepath")
    filename="${filename%.*}"
    echo "Building $filename"
    openscad -o build/"$filename".stl -D "minor_version=\"$git_commit\"" -p "$filepath" -P "design default values" phone_case.scad
done