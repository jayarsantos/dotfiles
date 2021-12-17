#!/usr/bin/env bash

update_MyConfigs(){
cd ~/MyConfigs
echo "You are in MyConfigs Folder"

if [[ -n $(git status -s) ]]; then
    echo "Changes found. Pushing changes..."
    git add -A && git commit -m 'update' && git push origin main
else
    echo "No changes found. Skip pushing."
fi

echo "Exiting Folder"

}

update_LoanApp(){
cd ~/LoanApp
echo "You are in LoanApp Folder"

if [[ -n $(git status -s) ]]; then
    echo "Changes found. Pushing changes..."
    git add -A && git commit -m 'update' && git push origin main
else
    echo "No changes found. Skip pushing."
fi

echo "Exiting Folder"

}

case "$1" in
'DotFiles')
update_MyConfigs
;;
'LoanApp')
update_LoanApp
;;
'all')
update_LoanApp &
update_MyConfigs
;;
'')
echo "script preceeding DotFiles, LoanApp, or all"
;;
esac
