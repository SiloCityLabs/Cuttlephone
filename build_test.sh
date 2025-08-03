#!/bin/bash 

version="v 0.5"
git_commit=$(git rev-parse --short HEAD)
filetype='3mf'

#create build dir (ignored by git)
mkdir -p build

#TODO: pull these from the JSON
declare -a case_types=( "phone case" "junglecat" "joycon" "joycon2" )
declare -a case_materials=( "hard" "soft" )
declare -A case_thicknesses
#test cases can be made thinner than usual, it doesn't need to last, we just need to validate the geometry
case_thicknesses[hard]=1.2
case_thicknesses[soft]=1.0

# pick 1 phone model and build all variants
model="Pixel 4a"
echo "Building all variants of $model"
echo

for case_type in "${case_types[@]}"; do
    for case_material in "${case_materials[@]}"; do

        filename="${model} ${case_type} ${case_material}.${filetype}"
        case_thickness=${case_thicknesses[$case_material]}
        
        echo "Building ${filename}"
        #openscad -o build/"${filename}" -D "case_type_override=\"$case_type\"; case_material_override=\"$case_material\"; case_thickness_override=\"$case_thickness\"; version=\"$version-$git_commit\";" -p phone_case.json -P "${model}" phone_case.scad
        echo
    done
done

exit;


