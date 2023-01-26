#!/bin/bash 

version="v 0.4"
git_commit=$(git rev-parse --short HEAD)

#create build dir (ignored by git)
#TODO: should I skip this dir and put the files directly in premade_models_path?
mkdir -p build

#change split char to help jq parse the JSON
IFS=""
#fetch phone models from JSON. Strip \r from Windows JSON
presets_jq=$(jq -r '.[] | select(type == "object") | keys[]' phone_case.json | tr -d '\r')
echo "Available phone models:" 
echo $presets_jq
echo
#turn presets into an array, splitting on the newline
IFS=$'\n'
presets=($presets_jq)
unset IFS

#TODO: pull these from the JSON 
#TODO: enable "gamepad" when it works
declare -a case_types=( "phone case" "junglecat" "joycon" )
declare -a case_materials=( "hard" "soft" )
declare -A case_thicknesses
#cases made with PLA+ need to be at least 2.0mm thick to resist cracking
case_thicknesses[hard]=2.0
#soft cases can be thin
case_thicknesses[soft]=1.4

filetype='3mf'
echo "Building all configs"
echo

#loop through all case configs and build models
for model in "${presets[@]}"; do
    # choose which variants to build
    build_phone=$(jq -r --arg model "$model" '.[] | select(type == "object")[$model].build_phone' phone_case.json)
    build_junglecat=$(jq -r --arg model "$model" '.[] | select(type == "object")[$model].build_junglecat' phone_case.json)
    build_joycon=$(jq -r --arg model "$model" '.[] | select(type == "object")[$model].build_joycon' phone_case.json)
    build_soft=$(jq -r --arg model "$model" '.[] | select(type == "object")[$model].build_soft' phone_case.json)
    build_hard=$(jq -r --arg model "$model" '.[] | select(type == "object")[$model].build_hard' phone_case.json)
    
    echo "$model"
    for case_type in "${case_types[@]}"; do
    # choose which variants to build
    if { [ "$build_phone" = true ] && [ "$case_type" = "phone case" ]; } \
        || { [ "$build_junglecat" = true ] && [ "$case_type" = "junglecat" ]; } \
        || { [ "$build_joycon" = true ] && [ "$case_type" = "joycon" ]; }; then
        
        for case_material in "${case_materials[@]}"; do
        if { [ "$build_soft" = true ] && [ "$case_material" = "soft" ]; } \
        || { [ "$build_hard" = true ] && [ "$case_material" = "hard" ]; }; then
            filename="${model} ${case_type} ${case_material}.${filetype}"
            case_thickness=${case_thicknesses[$case_material]}
            
            echo "Building ${filename}"
            openscad -o build/"${filename}" -D "case_type_override=\"$case_type\"; case_material_override=\"$case_material\"; case_thickness_override=\"$case_thickness\"; version=\"$version-$git_commit\";" -p phone_case.json -P "${model}" phone_case.scad
            echo
        fi
        done
    fi
    done
done

exit;


