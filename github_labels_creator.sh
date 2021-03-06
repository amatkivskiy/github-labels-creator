#!/bin/bash
label_names=(
	'Status: Changes Requested' 
	'Status: Do Not Merge' 
	'Status: Help Wanted' 
	'Status: In Progress' 
	'Status: Mergeable' 
	'Status: Review Needed' 
	'Type: Bug' 
	'Type: Duplicate' 
	'Type: Enhancement' 
	'Type: Question' 
	'Type: Wontfix'
)
label_colors=(
	'fbca04' 
	'd90ba8' 
	'1d76db' 
	'd4c5f9' 
	'128A0C' 
	'5319e7' 
	'ee0701' 
	'cccccc' 
	'84b6eb' 
	'cc317c' 
	'ffffff'
)
default_labels=(
	'bug'
	'duplicate'
	'enhancement'
	'invalid'
	'question'
	'wontfix'
	'help%20wanted'
	'good%20first%20issue'
)

echo ''
echo "This script will delete default labels and create custom repository labels."
echo ''
echo "First argument should be Github Auth token to authorize Github API Reqests,"
echo "Second argument should be oranization/repository name (like: 'square/retrofit')."
echo ''
echo "Example: github_labels_creator.sh token square/retrofit"
echo ''
echo "Do not forget to grant execute permission to the script by chmod +x github_labels_creator.sh otherwise you will face an error: github_labels_creator.sh: Permission denied"
echo ''
echo "Default label names:"
printf '%s\n' "${label_names[@]}"

if [[  $# -eq 0 ]]; then
	echo "Not enough parameters for the script to work."
	exit
fi

github_token=$1
repository=$2

# Delete default labels
for ((i=0;i<${#default_labels[@]};++i)); do
    response=$(curl --write-out %{http_code} \
      --silent \
      --output /dev/null \
	  -X DELETE \
	  "https://api.github.com/repos/$repository/labels/${default_labels[i]}" \
	  -H "authorization: token $github_token" )

	if [ "$response" -eq "204" ]
	then
		echo "Label ${default_labels[i]} has been successfuly deleted"
	else
		echo "Failed to delete ${default_labels[i]}. Code $response"
	fi
done 

# Create custom labels
for ((i=0;i<${#label_names[@]};++i)); do
	response=$(curl --write-out %{http_code} \
      --silent \
      --output /dev/null \
	  -X POST \
	  "https://api.github.com/repos/$repository/labels" \
	  -H "authorization: token $github_token" \
	  -H "content-type: application/json" \
	  -d "{\"name\": \"${label_names[i]}\",\"color\": \"${label_colors[i]}\"}")

	if [ "$response" -eq "201" ]
	then
		echo "Successfuly created label ${label_names[i]}"
	else
		echo "Failed to create ${label_names[i]}. Code $response"
	fi
done
