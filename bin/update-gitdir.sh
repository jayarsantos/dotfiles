#!/usr/bin/env bash

dir1=$HOME/git/dotfiles
dir2=$HOME/LoanApp

git_push(){
    dirs=$dir1:$dir2

    # Replace colons with spaces to create list.
    for dir in ${dirs//:/ }; do

        cd $dir
        
        if [[ 'git status --porcelain' ]]; then
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
            echo "$dir is up-to-date"
        else
            git pull
        fi
    done

}

case "$1" in
    'push')
        git_push
        ;;
    'pull')
        git_pull
        ;;
    'pullpush')
        git_pull &&
        git_push
        ;;
'')
echo "script preceeding pull, push, or pullpush"
;;
esac
