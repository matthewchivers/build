#!/bin/sh +e

echo "Checking for changes"
CHANGED=$(git status -s .)
echo $CHANGED

if [ -z "$CHANGED" ]; then
    echo "No changes detected"
    exit 0
fi

echo "Configing user"
git config user.name '$VERSION_USER'
git config user.email $VERSION_EMAIL

echo "Adding changes"
git add .

echo "Committing changes"
git commit -m "Version change - $VERSION_CHANGE $BUILD_TAG"

echo "Pushing branch"
git push -f origin $VERSION_BRANCH


echo "Checking for Pull Request"
PR=$(hub pr list -h $VERSION_BRANCH)
echo $PR
if [ ! -z "$PR" ]; then
   echo 'Pull Request is open'
  exit 0
fi

echo "No Pull Request exists, creating one"

hub pull-request -b master -h $VERSION_BRANCH -m "Autogenned version change $VERSION_CHANGE" -m "Jenkins run $BUILD_TAG" -r $VERSION_REVIEWERS