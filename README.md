# Github labels creator
A fancy tool to automate creation of helpfull  labels set for Github repository.

- first argument should be [Github Auth token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) to authorize Github API Reqests
- second argument should be `oranization/repository` name (like: __square/retrofit__).

Example: `github_labels_creator.sh token square/retrofit`

:warning: Do not forget to grant execute permission to the script by `chmod +x github_labels_creator.sh` otherwise you will face an error: 
`github_labels_creator.sh: Permission denied`


### Default labels and their colors:
![Default labels](https://raw.githubusercontent.com/amatkivskiy/github-labels-creator/master/default_labels.png)
