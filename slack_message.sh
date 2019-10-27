#!/bin/bash
####################################################################################
# Bash script to renew easy-rsa certificate using autocertbot
####################################################################################
# Installation
#
# Just declare the enviroment variables and execute the script
####################################################################################
# USAGE
# This script sends a simple text message to a given slack channel or chat
#
# VARIABLES
#   - channel_id: set the channel you want to send messages to
# 
#
# Please declare environment variables:
#   - SLACK_TOKEN: your slack app token

# You can change channel_id to match any channel you want the messages to go
#
# Be sure to specify the certbot_path to match your certbot-auto full path
#
####################################################################################


# channel_id is the id of the channel that messages should be sent
channel_id=''

# Setting the default response
response=""

# generate_post_data function was based on the accepted answer in
# https://stackoverflow.com/questions/17029902/using-curl-post-with-variables-defined-in-bash-script-functions

generate_post_data()
{
    cat <<EOF
{
  "channel": "$channel_id",
  "text": "$response"
}
EOF
}

send_slack_message(){
    curl -X POST -H "Content-type: application/json" \
	 -H "Authorization: Bearer $SLACK_TOKEN" \
	 -d "$(generate_post_data)" \
	 https://slack.com/api/chat.postMessage
}

if [ "$#" -ne "1" ]; then
    echo Wrong number of arguments, expected only one
    exit 1
fi

response=$1
send_slack_message
