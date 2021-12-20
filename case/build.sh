#!/bin/bash 

version="v0.2"
git_commit=$(git rev-parse --short HEAD)

#create build dir (ignored by git)
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

#TODO: pull these from the JSON
declare -a case_types=( "phone case" "junglecat" "joycon" "gamepad" )
declare -a case_materials=( "hard" "soft" )
filetype='3mf'
echo "Building all configs"

#put models and variables on websites
jekyll_data_dir='../docs/_data/'
echo "copy phone_case.json"
cp phone_case.json $jekyll_data_dir
premade_models_path='../docs/premade-models/'

ymlpath='../docs/_data/premade_models.yml'
echo '' > $ymlpath

for model in "${presets[@]}"; do
	echo "- model: ${model}" >> $ymlpath
done

for model in "${presets[@]}"; do
	echo "- header: ${model}" >> $ymlpath
    for case_type in "${case_types[@]}"; do
        for case_material in "${case_materials[@]}"; do
			filename="${model} ${case_type} ${case_material}.${filetype}"
            echo "Building ${filename}"
			#openscad -o build/"${filename" -D "case_type_override=\"$case_type\"; case_material_override=\"$case_material\"; version=\"$version-$git_commit\";" -p phone_case.json -P "${model}" phone_case.scad
			
			#write filenames to website YML
			echo "- model: ${model}" >> $ymlpath
			echo "  title: ${model}, ${case_type}, ${case_material} plastic" >> $ymlpath
			echo "  case_type: ${case_type}" >> $ymlpath
			echo "  case_material: ${case_material} plastic" >> $ymlpath
			echo "  filename: ${filename}" >> $ymlpath
			cp "build/${model} ${case_type} ${case_material}.${filetype}" $premade_models_path
        done
    done
done

exit;


