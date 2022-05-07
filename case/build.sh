#!/bin/bash 

version="v0.3"
git_commit=$(git rev-parse --short HEAD)

#create build dir (ignored by git)
#TODO: should I skip this dir and put the files directly in premade_models_path?
mkdir -p build

#change split char to help jq parse the JSON
IFS=""
#fetch phone models from JSON. Strip \r from Windows JSON
presets_jq=($(jq -r '.[] | select(type == "object") | .[] | .phone_model' phone_case.json | tr -d '\r'))
echo "Available phone models:" 
echo $presets_jq
echo
#turn presets into an array, splitting on the newline
IFS=$'\n'
presets=($presets_jq)
unset IFS

#put models and variables on websites
jekyll_data_dir='../docs/_data/'
echo "Copying configs to website"
echo
cp phone_case.json $jekyll_data_dir
premade_models_path='../docs/premade-models/'

#TODO: pull these from the JSON #TODO: add "gamepad" when it works
declare -a case_types=( "phone case" "junglecat" "joycon" )
declare -a case_materials=( "hard" "soft" )
filetype='3mf'
echo "Building all configs"
echo

#loop through all case configs and build models
for model in "${presets[@]}"; do
    for case_type in "${case_types[@]}"; do
        for case_material in "${case_materials[@]}"; do
            filename="${model} ${case_type} ${case_material}.${filetype}"
            
            echo "Building ${filename}"
            openscad -o build/"${filename}" -D "case_type_override=\"$case_type\"; case_material_override=\"$case_material\"; version=\"$version-$git_commit\";" -p phone_case.json -P "${model}" phone_case.scad
            echo
            
            cp "build/${filename}" $premade_models_path
        done
    done
done

exit;


