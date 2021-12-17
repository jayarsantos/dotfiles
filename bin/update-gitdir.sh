#!/usr/bin/env bash

git_push(){

dir1=$HOME/MyConfigs
dir2=$HOME/LoanApp

    for dir in dir1 dir2
    do
        if [ -z "$(ls -A $dir$i)" ]; then
            echo "Empty"
        else
            echo "Not Empty"
        fi
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
