#!/usr/bin/env bash

dir1=$HOME/MyConfigs
dir2=$HOME/LoanApp

git_push(){
    dirs=$dir1:$dir2

    # Replace colons with spaces to create list.
    for dir in ${dirs//:/ }; do

        cd $dir

        if [[ -n $(git status -s) ]]; then
            echo "Changes found. Pushing changes in $dir..."
            git add -A && git commit -m 'update' && git push origin main
        else
            echo "No changes found in $dir. Skip pushing."
        fi

        echo "Exiting Folder"

    done

}

git_pull(){

    dirs=$dir1:$dir2

    # Replace colons with spaces to create list.
    for dir in ${dirs//:/ }; do

        cd $dir
        if git merge-base --is-ancestor origin/main main; then
            echo "Your git folders are up-to-date"
        else
            git pull
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
    'pull')
        git_pull
        ;;
'')
echo "script preceeding DotFiles, LoanApp, or all"
;;
esac
