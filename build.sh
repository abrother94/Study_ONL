#!/bin/bash
pfp="OpenNetworkLinux/packages/platforms/"
pfpa="OpenNetworkLinux/packages/platforms/accton/"
pfpam="OpenNetworkLinux/packages/platforms/accton/x86-64/"

sudo rm -rf OpenNetworkLinux
git clone https://github.com/opencomputeproject/OpenNetworkLinux

pf=`ls OpenNetworkLinux/packages/platforms/accton/x86-64/`

help_p()
{
reset
echo ""
echo "////////////////////////////////////////////////////////////////////////////////////////////////"
echo "$pf"
echo ""
}

if [ "$1" != "" ];then

    if [ $# -eq 0 ];then
	    help_p
	    exit 99
    fi

    if [[ $pf =~ $1 ]]; then
	echo "////////////You are building Accton's platform of [$1]/////////////////"
    else
	echo "$pf"
	exit 99
    fi

    #replace debug files
    #cp setup.env OpenNetworkLinux/
    #cp onlpm.py OpenNetworkLinux/tools/onlpm.py

    IFS='
    '
    DELA=($(ls $pfp -I 'Makefile' -I  'accton'))
    COUNT=${#DELA[@]}

    echo [$COUNT] 

    for (( c=0; c < "${COUNT}"; c++ ))
    do
	`rm -rf "$pfp${DELA[$c]}"`
    done

    DELA=($(ls $pfpa -I 'Makefile' -I  'vendor-config' -I 'x86-64'))
    COUNT=${#DELA[@]}
    echo [$COUNT] 
    for (( c=0; c < "${COUNT}"; c++ ))
    do
	`rm -rf "$pfpa${DELA[$c]}"`
    done

    DELA=($(ls $pfpam -I 'Makefile' -I  'modules' -I "$1"))
    COUNT=${#DELA[@]}
    echo [$COUNT] 
    for (( c=0; c < "${COUNT}"; c++ ))
    do
	`rm -rf "$pfpam${DELA[$c]}"`
    done

    cd OpenNetworkLinux
    apt-cacher-ng
    source setup.env
    make amd64  2>&1 | tee  onl.log 

else

    echo "////////////You are building ALL platform /////////////////"

    cd OpenNetworkLinux
    apt-cacher-ng
    source setup.env
    make amd64  2>&1 | tee  onl.log 

fi

