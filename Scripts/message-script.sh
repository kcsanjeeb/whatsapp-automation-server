#!/bin/bash

# Check if the number of arguments provided is correct
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <message_file> <mobile_number_file> <image_file>"
    exit 1
fi

message_file="$1"
mobile_number_file="$2"
image_file="$3"

# Read the message from the specified message file
message=$(<"$message_file")

# Check if the message is empty (contains only line breaks)
if [[ -z "$message" ]]; then
    echo "Message is empty. Exiting script."
    exit 1
fi

# Print the message
echo "Message to be sent:"
echo "$message"
echo

# Read the mobile numbers from the specified file
mapfile -t mobile_numbers < "$mobile_number_file"

# Iterate over the mobile numbers
for mobile_number in "${mobile_numbers[@]}"; do
    # Check if the mobile number is empty
    if [[ -z "$mobile_number" ]]; then
        echo "No mobile number specified. Exiting script."
        exit 1
    fi

    # Print the mobile number to which the message is being sent
    echo "Sending message to $mobile_number ..."
    
    # Execute the command with the current mobile number and the message
    npx mudslide send-image --caption "$message" "$mobile_number" "$image_file"
done

