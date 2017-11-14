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

echo ''
echo "This script will create default repository labels."
echo ''
echo "First argument should be Github Auth token to authorize Github API Reqests,"
echo "Second argument should be oranization/repository name (like: 'square/retrofit')."
echo ''
echo "Example: github_labels_creator.sh token square/retrofit"
echo ''
echo "Default label names:"
printf '%s\n' "${label_names[@]}"

if [[  $# -eq 0 ]]; then
	echo "Not enough parameters for the script to work."
	exit
fi

github_token=$1
repository=$2

# echo "Please enter github organization and repository name like 'organization/repository', followed by [ENTER]:"


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

