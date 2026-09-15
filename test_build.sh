#!/bin/bash 

version="v0.5"
git_commit=$(git rev-parse --short HEAD)
filetype='3mf'

#create build dir (ignored by git)
mkdir -p build

#TODO: pull these from the JSON
# declare -a case_types=( "phone case" "junglecat" "joycon" "joycon2" )
declare -a case_types=( "phone case" )
# declare -a case_materials=( "hard" "soft" )
declare -a case_materials=( "hard" )
declare -A case_thicknesses
#test cases can be made thinner than usual, it doesn't need to last, we just need to validate the geometry
case_thicknesses[hard]=1.2
case_thicknesses[soft]=1.0

# GitHub-safe filename. Do not rename OpenSCAD preset keys.
# spaces -> _, + -> plus, anything else outside [A-Za-z0-9._-] fails the build
safe_filename() {
    local name="$1"
    name="${name// /_}"
    name="${name//+/plus}"
    if [[ ! "$name" =~ ^[A-Za-z0-9._-]+$ ]]; then
        echo "Error: unsupported characters in filename: $name" >&2
        exit 1
    fi
    printf '%s' "$name"
}

# pick 1 phone model and build all variants
model="Pixel 4a"
echo "Building all variants of $model"
echo

for case_type in "${case_types[@]}"; do
    for case_material in "${case_materials[@]}"; do

        filename="$(safe_filename "${model} ${case_type} ${case_material}.${filetype}")"
        case_thickness=${case_thicknesses[$case_material]}
        
        echo "Building ${filename}"
        openscad -o build/"${filename}" \
            -p phone_case.json -P "${model}" phone_case.scad \
            -D "render_quality=\"nice\"; case_type_override=\"$case_type\"; case_material_override=\"$case_material\"; case_thickness_override=\"$case_thickness\"; version=\"$version-$git_commit\";" \
            ;
        echo
    done
done

exit;


