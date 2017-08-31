#!/bin/bash

BASEDIR=`pwd -P`

# Check if there are 4 arguments
if [ "$#" -ne 4 ]; then
  echo "Four arguments are required"
  exit 1
fi

github_account=$1
current_repo=$2
bitbucket_account=$3
new_repo=$4

migrate_github_to_bitbucket() {
  echo "** Attempting to Copying Github Repo to Bitbucket Repo **"
  
  # Start migrate process from github to bitbucket
  git clone --mirror https://github.com/${github_account}/${current_repo}.git && cd ${current_repo}.git/ && git remote set-url --push origin https://bitbucket.org/${bitbucket_account}/${new_repo}.git && git push --mirror 2> /dev/null
  
  if [ $? -eq 0 ]; then
    echo "** Bitbucket to Github migration successful **"
  else
    echo "** Bitbucket to Github migration failed **"    
  fi
}

migrate_github_to_bitbucket

# Clean Up Bitbucket Repo
if [ -d "$BASEDIR/$current_repo.git" ]; then
    printf '%s\n' "** Removing Repo Directory **"
    rm -rf ${BASEDIR}/${current_repo}.git/
fi
