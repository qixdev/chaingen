# #!/bin/bash

# if ! command -v jq &> /dev/null; then
#     echo "jq is required. Please install jq and try again."
#     exit 1
# fi

# if command -v go &> /dev/null; then
#     go_version=$(go version | awk '{print $3}')
#     required_version="go1.20" 
#     if [[ "$go_version" != "$required_version" ]]; then
#         echo "Golang version $required_version is required. Please install this version."
#         exit 1
#     fi
# else
#     if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
#         echo "Windows detected. Please ensure that Go is installed and available in your PATH."
#         exit 1
#     else
#         echo "Unsupported operating system. Please ensure that Go is installed and available in your PATH."
#         exit 1
#     fi
# fi

# flag_file=".script_run_flag"
# if [ -e "$flag_file" ]; then
#     previous_os=$(cat "$flag_file")
#     current_os=$(uname)
#     target_directory="ethereum-pos-testnet"
#     current_directory=$(pwd)
#     if [ "$current_directory" = "$target_directory" ]; then
#         echo "Running script"
#     else
#         cd $target_directory
#     fi
# else
#     uname > "$flag_file"
#     echo "First run on $current_os."
#     ./build-dependencies
# fi

# ./testnet.sh
mv geth.sh ../