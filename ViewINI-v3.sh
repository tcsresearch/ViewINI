#!/bin/env bash
# 
# Disable ShellCheck SC1090
# shellcheck source=/dev/null

# Disable ShellCheck SC2034
# shellcheck disable=SC2034  # Unused variables left for readability

# As of Oct 23, 2026, this is the latest and greatest version of ViewINI.sh
# TODO: Finalize and save as function for BLING


#######################################################################################
# Define Files and Folders. #							                                            #
#######################################################################################
  CONFIG_DIR="$(pwd)/config"

  CONFIG_FILE="BRCD-Loader.ini"

  FUNC_DIR="$(pwd)/functions"

  FUNC_FILE="lib_ini.bfunc"

# Colors for Cecho-like output
# Cannot find this file!  Falling back to the DefineColors function.
  COLORS_FILE="Colors2.conf"

# Define ShowINI Variables #
  ShowINI_Left="${brightyellow} $key ${brightred}"
  ShowINI_Center=" = "
  ShowINI_Right="${brightwhite} $value ${reset}"

# Define Left Column Width.
  L_Column_Width="25"

#######################################################################################
# Source Config & INI Library. #			                                    			      #
#######################################################################################

# Source our Color Config
function SourceColorConfig() {
        if [ -f "$CONFIG_DIR"/"$COLORS_FILE" ]; then
                source "$CONFIG_DIR"/"$COLORS_FILE"
        else
                echo "ERROR: Color Config File $CONFIG_DIR/$COLORS_FILE Not Found!"
        fi
}

# Source our INI Library
function SourceINILib() {
	if [ -f "$FUNC_DIR"/"$FUNC_FILE" ]; then
		source "$FUNC_DIR"/"$FUNC_FILE"
	else
		echo "ERROR: INI Library File $FUNC_DIR/$FUNC_FILE Not Found!"
	fi
}

#######################################################################################
# Sanity Checker - Ensure INI File Exists #		                            			      #
#######################################################################################

# Ensure our INI File Exists
function SanityChecker_INIFile() {
        if [ -f "$CONFIG_DIR"/"$CONFIG_FILE" ]; then
                source "$CONFIG_DIR"/"$CONFIG_FILE"
        else
                echo "ERROR: INI Configuration File $CONFIG_DIR/$CONFIG_FILE Not Found!"
        fi
}


## Call our SourceColorConfig function 
 SourceColorConfig # What is this?

#######################################################################################
# Message Function- Print_INI() #						                                		      #
#######################################################################################
# Define a function to print aligned messages
## FIXME: This needs work!

print_INI() {
    local keycolor="$1"
    local keyname="$2"
    local valuecolor="$3"
    local value_data="$4"
    local width="40" # Total width of the line

    # Calculate padding needed. We use printf's width specifier.
    # The format string ensures the message is left-aligned in a field
    # that accounts for the length of the status message.

    # We can use a simple trick with printf for alignment:
    # First, print the message left-aligned to a specific width.
    printf "%-35s" "$keyname"
    # Then print the status message.
    printf "%s\n" "$value_data"
}

#######################################################################################
#######################################################################################
## Main Program ## 								                                                    #
#######################################################################################
#######################################################################################

# Show name of config file.
echo "${brightyellow}Config File: ${brightblue}$CONFIG_FILE ${reset}"
echo " "

# List sections and keys
echo "${brightyellow}Available sections: ${reset}"
echo "${brightyellow}-------------------${reset}"
echo " "

#######################################################################################
# INI List Functions #									                              							  #
#######################################################################################

ini_list_sections "$CONFIG_DIR/$CONFIG_FILE" | while read -r section; do
       echo "${brightblue} [$section] ${reset}"
	   
ini_list_keys "$CONFIG_DIR/$CONFIG_FILE" "$section" | while read -r key; do
       value=$(ini_read "$CONFIG_DIR/$CONFIG_FILE" "$section" "$key")
       echo "  - ${brightyellow} $key ${brightred} = ${brightwhite} $value ${reset}"
	
	done
echo " "

done

#################################################################################################
# FUTURE DEVELOPMENT ? #                                                                        #
#################################################################################################
# Display Output #
# echo "$ShowINI_Left $ShowINI_Center $ShowINI_Right" | column -t -s ':' -o '='
## echo "$ShowINI_Left $ShowINI_Center $ShowINI_Right" | column -c 20 -s ':' -o '='


#####  These need development ##########
##	This one almost works.
#	printf "%-*s %s\n" $L_Column_Width   " - ${brightyellow} $key " "${brightred}     = "      "${brightwhite} $value ${reset}"

#	print_INI ${brightyellow} "$key" $(brightred) " = " ${brightwhite} "$value ${reset}"
