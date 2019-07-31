#!/usr/bin/env bash
# start: 16:10 29th July
# finish: 16:53 29th July

REMOTE_HOST=$1
PORT_RANGE=$2
echo $PORT_RANGE

# Check netcat is nominally installed
command -v nc
nc_check=$?

command -v netcat
netcat_check=$?

if [[ "$nc_check" == "0" ]]; then
    NC_CMD="nc"
fi

if [[ "$nc_check" != "0" && "$netcat_check" == "0" ]]; then
    NC_CMD="netcat"
fi

if [[ "$nc_check" != "0" && "$netcat_check" != "0" ]]; then
    echo "WARNING: netcat not found. Aborting."
    exit 1
fi

# Check remote host?


# Check port is numerical if only one is specified
if [[ $PORT_RANGE != *"-"* ]]; then
    echo "Single port detected."
    if [[ $PORT_RANGE == "" ]]; then
        echo "Port unset - aborting."
        exit 1
    fi
    # Check ports are actually numerical
    NUM_PATTERN='^[0-9]+$'
    if ! [[ $PORT_RANGE =~ $NUM_PATTERN ]] ; then
        echo "WARNING: the port was not numerical. Aborting." 
        exit 1
    fi
fi


# Check port range is valid if range is set
if [[ $PORT_RANGE == *"-"* ]]; then
    echo "Range detected - splitting."
    START_PORT="$(cut -d '-' -f1 <<< $PORT_RANGE)"
    END_PORT="$(cut -d '-' -f2 <<< $PORT_RANGE)"
    if [[ $START_PORT == "" ]]; then
        echo "Start port not set!"
    fi
    if [[ $END_PORT == "" ]]; then
        echo "End port not set!"
    fi
    # Check both ports aren't empty
    if [[ $START_PORT == "" && $END_PORT == "" ]]; then
        echo "Start port and end port not set. Aborting."
        exit 1
    fi

    # Check ports are actually numerical
    NUM_PATTERN='^[0-9]+$'
    if ! [[ $START_PORT =~ $NUM_PATTERN && $END_PORT =~ $NUM_PATTERN ]] ; then
        echo "WARNING: one of the ports was not numerical. Aborting." 
        exit 1
    fi

    echo $START_PORT
    echo $END_PORT
    # Check start port is lower than end port otherwise it'll break
    if [[ $START_PORT < $END_PORT ]]; then
        echo "Range looks OK."
    elif [[ $START_PORT == $END_PORT ]]; then
        echo "Ports are the same!"
        # Just overwrite the $PORT_RANGE var with the start port, for ease of use
        PORT_RANGE = $START_PORT
    else
        echo "Start port can't be higher than the end port. Aborting."
        exit 1
    fi
fi



# Actually perform the scan
$NC_CMD -v -z -n $REMOTE_HOST $PORT_RANGE > output.txt 2>&1