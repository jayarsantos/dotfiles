#!/usr/bin/env bash

dir1=$HOME/MyConfigs
dir2=$HOME/LoanApp

git_push(){
    dirs=$dir1:$dir2

    # Replace colons with spaces to create list.
    for dir in ${dirs//:/ }; do
        echo "$path"
    done

}

update_MyConfigs(){

cd ~/MyConfigs
dir=$(pwd)
echo "You are in $dir"

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
dir=$(pwd)
echo "You are in $dir"

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
        update_LoanApp &&
        update_MyConfigs
        ;;
    'push')
        git_push
        ;;
'')
echo "script preceeding DotFiles, LoanApp, or all"
;;
esac
