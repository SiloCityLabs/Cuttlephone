#! /bin/bash 

version="v0.1"
git_commit=$(git rev-parse --short HEAD)

#change split char to help jq parse the JSON. Can't remember exactly why
export IFS=""
#gets name from phone_model variable
presets=$(jq -r '.[] | select(type == "object") | .[] | .phone_model' phone_case.json)
export IFS='
'
#why don't I pull this from the JSON?
declare -a case_types=( "phone case" "junglecat" "joycon" "gamepad" )
echo "Building all configs"

for model in $presets; do
    for case_type in "${case_types[@]}"; do
        echo "Building ${model} ${case_type}.3mf"
        openscad -o build/"${model} ${case_type}".3mf -D "case_type_override=\"$case_type\"; version=\"$version $git_commit\";" -p phone_case.json -P "${model}" phone_case.scad
    done
done

exit;
