#!/bin/bash

# find ~/ -type f -name "vite.config.ts" run to manually find the files 

# Define the code to be inserted. The '\n' are for new lines.
CODE_TO_ADD='  server: {\n    watch: {\n      usePolling: true,\n      interval: 1000\n    }\n  },'

# Define the search pattern for the line to insert after
SEARCH_PATTERN='base: base,'

# The starting directory for the search
START_DIR="/home/ou/TM352-25J/"

# Check the operating system to determine the correct sed syntax
OS_TYPE=$(uname)

echo "Searching for all vite.config.ts files in $START_DIR and its subdirectories..."

# Use find to locate all files and loop through them
find "$START_DIR" -name "vite.config.ts" -print0 | while IFS= read -r -d $'\0' file; do
    echo "Processing: $file"

    # Check if the file already contains the 'server.watch' configuration
    if grep -q "server: {" "$file"; then
        echo "  - The 'server' configuration already exists. Skipping."
    else
        # Use sed to find the line and insert the new code
        # The syntax for in-place editing is different on Linux and macOS
        if [ "$OS_TYPE" == "Linux" ]; then
            # Linux sed does not require a backup extension
            if sed -i "/$SEARCH_PATTERN/a \\$CODE_TO_ADD" "$file"; then
                echo "  - Added the 'server' configuration successfully."
            else
                echo "  - Error: Failed to add the 'server' configuration."
            fi
        elif [ "$OS_TYPE" == "Darwin" ]; then
            # macOS sed requires a backup extension argument, even an empty one
            if sed -i '' "/$SEARCH_PATTERN/a \\$CODE_TO_ADD" "$file"; then
                echo "  - Added the 'server' configuration successfully."
            else
                echo "  - Error: Failed to add the 'server' configuration."
            fi
        else
            echo "  - Warning: Unknown OS type ($OS_TYPE). Skipping sed command."
        fi
    fi
    echo ""
done

echo "Script finished. All relevant files have been updated."
