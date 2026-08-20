#!/usr/bin/env bash

# Define Files and Folders.
  CONFIG_DIR="$(pwd)/config/_Old"

# CONFIG_FILE="test.ini"
#  CONFIG_FILE="config.ini"
  CONFIG_FILE="RepoSync-ng.ini"

# Functions
  FUNC_DIR="$(pwd)/functions"
  FUNC_FILE="lib_ini.bfunc"

# Colors for Cecho-like output
  COLORS_FILE="Colors.conf"

# Source our Color Config
if [ -f "$CONFIG_DIR"/"$COLORS_FILE" ]; then
	source "$CONFIG_DIR"/"$COLORS_FILE"
fi


### This section is depricated and can be removed after testing.
function DefineColors() {
# shellcheck disable=SC2034  # Unused variables left for readability
# Define Our Colors
# Define color variables
  black="$(tput setaf 0)"
  red="$(tput setaf 1)"
  green="$(tput setaf 2)"
  yellowbrown="$(tput setaf 3)"
  blue="$(tput setaf 4)"
  magenta="$(tput setaf 5)"
  cyan="$(tput setaf 6)"
  whitelightgray="$(tput setaf 7)"
  whitelightgrey="$(tput setaf 7)"
  brightblack_darkgray="$(tput setaf 8)"
  brightblack_darkgrey="$(tput setaf 8)"
  brightred="$(tput setaf 9)"
  brightgreen="$(tput setaf 10)"
  brightyellow="$(tput setaf 11)"
  brightblue="$(tput setaf 12)"
  brightmagenta="$(tput setaf 13)"
  brightcyan="$(tput setaf 14)"
  brightwhite="$(tput setaf 15)"
  reset="$(tput sgr0)" # Reset to default 
}

# DefineColors

# Define Left Column Width
L_Column_Width="25"


# Message Function
# Define a function to print aligned messages
## FIXME: This needs work!

print_INI() {
    local keycolor="$1"
    local keyname="$2"
    local valuecolor="$3"
    local value_data="$4"
    local width=40 # Total width of the line

    # Calculate padding needed. We use printf's width specifier.
    # The format string ensures the message is left-aligned in a field
    # that accounts for the length of the status message.

    # We can use a simple trick with printf for alignment:
    # First, print the message left-aligned to a specific width.
    printf "%-35s" "$keyname"
    # Then print the status message.
    printf "%s\n" "$value_data"
}

# Source our INI Library
# TODO: Add Sanity Check
source "$FUNC_DIR"/"$FUNC_FILE"



# List sections and keys
echo "Available sections:"
echo "-------------------"
echo " "
ini_list_sections "$CONFIG_DIR/$CONFIG_FILE" | while read section; do
###    echo "- $section"
###    echo " [ $section ]"
    cecho blue " [ $section ]"
###    echo "  Keys:"
    ini_list_keys "$CONFIG_DIR/$CONFIG_FILE" "$section" | while read key; do
        value=$(ini_read "$CONFIG_DIR/$CONFIG_FILE" "$section" "$key")
###        echo "  - $key = $value"

####### This one works ###########
#	echo "  - ${brightyellow} $key ${brightred}	=	${brightwhite} $value ${reset}" | column -t -s ':' -o '='
	
##	echo "  - ${brightyellow} $key ${brightred}     =       ${brightwhite} $value ${reset}" | column -c 20 -s ':' -o '='

	echo "  - ${brightyellow} $key ${brightred}     =       ${brightwhite} $value ${reset}" 

#####  These need development ##########
#	printf "%-*s %s\n" $L_Column_Width   " - ${brightyellow} $key " "${brightred}     = "      "${brightwhite} $value ${reset}"

#	print_INI ${brightyellow} "$key" $(brightred) " = " ${brightwhite} "$value ${reset}"
	done
echo " "
done
