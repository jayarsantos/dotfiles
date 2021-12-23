#!/usr/bin/env bash

dir1=$HOME/git/dotfiles
dir2=$HOME/LoanApp

git_push(){
    dirs=$dir1:$dir2

    # Replace colons with spaces to create list.
    for dir in ${dirs//:/ }; do

        cd $dir
        
        VN=$(git describe --abbrev=7 HEAD 2>/dev/null)

        git update-index -q --refresh
        CHANGED=$(git diff-index --name-only HEAD --)
        if [ -n "$CHANGED" ]; then
            VN="$VN-mod"
            echo "this is VN $VN"
        fi

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

push_MyConfigs(){

cd $dir1
echo "You are in $dir1"

if [[ -n $(git status -s) ]]; then
    echo "Changes found. Pushing changes..."
    git add -A && git commit -m 'update' && git push origin main
else
    echo "No changes found. Skip pushing."
fi

echo "Exiting Folder"

}

push_LoanApp(){

cd $dir2
echo "You are in $dir2"

if [[ -n $(git status -s) ]]; then
    echo "Changes found. Pushing changes..."
    git add -A && git commit -m 'update' && git push origin main
else
    echo "No changes found. Skip pushing."
fi

echo "Exiting Folder"

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
echo "script preceeding DotFiles, LoanApp, or all"
;;
esac
