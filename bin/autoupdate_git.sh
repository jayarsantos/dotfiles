#!/usr/bin/env bash

update_MyConfigs(){
cd ~/MyConfigs

if [[ -n $(git status -s) ]]; then
    echo "Changes found. Pushing changes..."
    git add -A && git commit -m 'update' && git push origin main
else
    echo "No changes found. Skip pushing."
fi

}

update_LoanApp(){
cd ~/LoanApp

if [[ -n $(git status -s) ]]; then
    echo "Changes found. Pushing changes..."
    git add -A && git commit -m 'update' && git push origin main
else
    echo "No changes found. Skip pushing."
fi
}

case "$1" in
'DotFiles')
update_MyConfigs
;;
'LoanApp')
update_LoanApp
;;
'All')
update_LoanApp
;;
'')
echo "script preceeding DotFiles, LoanApp, or All"
;;
esac
