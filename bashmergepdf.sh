#!/bin/bash
# Debug bash
if [ "$1" == "Debug" ] ; then set -x ; fi
clear
# color costants
black="\e[0;30m\033[1m"
redColour="\e[0;31m\033[1m"
greenColour="\e[0;32m\033[1m"
yellowColour="\e[1;33m\033[1m"
orangeColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
white="\e[1;37m\033[1m"
endColour="\033[0m\e[0m"
RC=0
ERROR=0
trap ctrl_c INT
# Trap Ctr+C
function ctrl_c(){
	echo -e "\n\n${yellowColour}[*]${endColour}${grayColour} Leaving ${greenColour}${0}${grayColour} ..."
    # Delete files
	exit 0
}
# Exit whit 1
function exit_1(){
    echo -e "${yellowColour}[*]${endColour}${grayColour} Leaving ${greenColour}${0}${grayColour} ..."
    exit 1
}
function bannerDBZ(){
	echo -e "\n${redColour}'||''|.                     ||       '||  '||''|.                           '||''|.   '||''|.   |'''''||  "
        echo -e " ||   ||   ....   .... ... ...     .. ||   ||   ||   ....     ....  ......   ||   ||   ||   ||      .|'   "
        echo -e " ||    || '' .||   '|.  |   ||   .'  '||   ||'''|.  '' .||  .|...|| '  .|'   ||    ||  ||'''|.     ||     "
        echo -e " ||    || .|' ||    '|.|    ||   |.   ||   ||    || .|' ||  ||       .|'     ||    ||  ||    ||  .|'     ${endColour}${yellowColour}(${endColour}${grayColour}Create By ${endColour}${redColour} DBZ - ${endColour}${purpleColour} Merge PDF files (V 1.0.0)..${endColour}${yellowColour})${endColour}${redColour}"
        echo -e ".||...|'  '|..'|'    '|    .||.  '|..'||. .||...|'  '|..'|'  '|...' ||....| .||...|'  .||...|'  ||......| ${endColour}\n\n"
        sleep  0.5
}
function mergepdf(){
    #NAME=`echo $1 | cut -d '/' -f3`
    NAME=`echo "${1}" | cut -d '/' -f3`
    echo -e "\t${blueColour}[*] ${greenColour} Merge directory ${turquoiseColour}${NAME}${yellowColour}"
    if ! [[ -f $1/$FINAL$NAME$FINALARCHIVO ]]; then
        qpdf --empty --pages $(for i in $1/*.pdf; do echo $i 1-z; done) -- $1/$FINAL$NAME$FINALARCHIVO
        echo -e "\t\t${turquoiseColour}[*] ${greenColour} File merge ${greenColour}${FINAL}${NAME}${FINALARCHIVO}${yellowColour} of the folder ${blueColour}$NAME"
    else
        echo -e "\t\t${blueColour}[*] ${redColour} File already exitsted ${greenColour}${FINAL}${NAME}${FINALARCHIVO}${yellowColour} of the folder ${blueColour}$NAME"
    fi
}
function directory(){
    echo -e "${purpleColour}[*] ${greenColour} Start --> ${blueColour} Merge proccess"
    for filename in ./pdffiles/*
    do
        FINAL="202206-"
        FINALARCHIVO="-CONSOLIDADO.pdf"
        FILES=`echo $filename`
        #echo $FILES
        mergepdf $FILES
    done;
    echo -e "${purpleColour}[*] ${greenColour} End --> ${blueColour}Merge proccess"
}
#bannerDBZ
directory