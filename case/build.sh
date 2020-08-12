#! /bin/bash 

git_commit=$(git rev-parse --short HEAD)

export IFS=""
#gets name from phone_model variable
presets=$(jq -r '.[] | select(type == "object") | .[] | .phone_model' phone_case.json)
#get name from object keys
#presets=$(jq -r '.[] | select(type == "object") | keys[]' phone_case.json)

echo "Building all configs"
export IFS='
'
for model in $presets; do
    echo "Building ${model}.stl"
    openscad -o build/"$model".stl -D "minor_version=\"$git_commit\"" -p phone_case.json -P "parameterSets" phone_case.scad
done

exit;
