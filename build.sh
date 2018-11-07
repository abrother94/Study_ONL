#!/bin/bash
# To saving time to build specific accton's platform, not build all platform #

pfp="OpenNetworkLinux/packages/platforms/"
pfpa="OpenNetworkLinux/packages/platforms/accton/"
pfpam="OpenNetworkLinux/packages/platforms/accton/x86-64/"
pfpam_arm="OpenNetworkLinux/packages/platforms/accton/armel/"

#sudo rm -rf OpenNetworkLinux
#git clone https://github.com/opencomputeproject/OpenNetworkLinux

pf=`ls OpenNetworkLinux/packages/platforms/accton/x86-64/`
pf_arm=`ls OpenNetworkLinux/packages/platforms/accton/armel/`

ARCH=$2

help_p()
{
reset
echo "./build.sh platfomr_name [arch:x86-64 armel]"
echo "x86-64 ////////////////////////////////////////////////////////////////////////////////////////////////"
echo "$pf"
echo "armel  ////////////////////////////////////////////////////////////////////////////////////////////////"
echo "$pf_arm"
echo "///////////////////////////////////////////////////////////////////////////////////////////////////////"

echo ""
}

if [ "$1" != "" ];then

    if [ $# -eq 1 ];then
	    help_p
	    exit 99
    fi

    if [[ $pf =~ $1 ]]; then

	echo "////////////You are building Accton's x86-64 platform of [$1]/////////////////"

    elif [[ $pf_arm =~ $1 ]];then

	echo "////////////You are building Accton's armel platform of [$1]/////////////////"

    else

	echo "$pf"
        echo "$pf_arm"
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

    # Clean other company's platform
    DELA=($(ls $pfpa -I 'Makefile' -I  'vendor-config' -I ${ARCH}))
    COUNT=${#DELA[@]}
    echo [$COUNT] 
    for (( c=0; c < "${COUNT}"; c++ ))
    do
	`rm -rf "$pfpa${DELA[$c]}"`
    done

    if [ "$ARCH" == "x86-64" ];then

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

        make amd64  2>&1 | tee  onl_x86-64.log 
    elif [ "$ARCH" == "armel" ];then

        DELA=($(ls $pfpam_arm -I 'Makefile' -I  'modules' -I "$1"))
        COUNT=${#DELA[@]}

        echo [there are $COUNT other platforms] 
        for (( c=0; c < "${COUNT}"; c++ ))
        do
	    echo "rm $pfpam_arm${DELA[$c]}"
	    #`rm -rf "$pfpam_arm${DELA[$c]}"`
        done


        cd OpenNetworkLinux
        apt-cacher-ng
        source setup.env

        make armel  2>&1 | tee  onl_armel.log 
    else
	echo "Need have ARCH type , x86-64 or armel"
    fi

else

    echo "////////////You are building ALL platform /////////////////"

    #cd OpenNetworkLinux
    #apt-cacher-ng
    #source setup.env
    #make amd64  2>&1 | tee  onl.log 

fi

