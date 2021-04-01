#! /bin/bash 

git_commit=$(git rev-parse --short HEAD)

export IFS=""
#gets name from phone_model variable
presets=$(jq -r '.[] | select(type == "object") | .[] | .phone_model' phone_case.json)
#get name from object keys
#presets=$(jq -r '.[] | select(type == "object") | keys[]' phone_case.json)

declare -a case_types=( "phone case" "junglecat" "joycon" "gamepad" )

echo "Building all configs"
export IFS='
'
for model in $presets; do
    for case_type in "${case_types[@]}"; do
        echo "Building ${model} ${case_type}.3mf"
        #todo: fix -D to predfine variables
        openscad -o build/"$model".3mf -D "case_type_override=\"$case_type\"" -p phone_case.json -P "$model" phone_case.scad
    done
done

exit;
