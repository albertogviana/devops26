# Links to gists for creating a cluster with jx
# gke-jx-serverless.sh: https://gist.github.com/fe18870a015f4acc34d91c106d0d43c8
# eks-jx-serverless.sh: https://gist.github.com/f4a1df244d1852ee250e751c7191f5bd
# aks-jx-serverless.sh: https://gist.github.com/b07f45f6907c2a1c71f45dbe0df8d410
# install-serverless.sh: https://gist.github.com/7b3b3d90ecd7f343effe4fff5241d037

cd go-demo-6

git checkout master

# If GKE
cat charts/go-demo-6/Makefile \
    | sed -e \
    "s@vfarcic@$PROJECT@g" \
    | tee charts/go-demo-6/Makefile

# If GKE
cat charts/preview/Makefile \
    | sed -e \
    "s@vfarcic@$PROJECT@g" \
    | tee charts/preview/Makefile

# If GKE
cat skaffold.yaml \
    | sed -e \
    "s@vfarcic@$PROJECT@g" \
    | tee skaffold.yaml

jx import --batch-mode

jx get activities \
    --filter go-demo-6 \
    --watch

cd ..

jx get applications

jx create devpod --label go --batch-mode

jx rsh -d

cd go-demo-6

curl -L \
  -o /usr/local/bin/jx-release-version \
  https://github.com/jenkins-x/jx-release-version/releases/download/v1.0.17/jx-release-version-linux

chmod +x \
  /usr/local/bin/jx-release-version

git tag

jx-release-version

git tag v1.0.0

jx-release-version

exit

jx delete devpod

git add .

git commit \
    --message "Finally 1.0.0"

git push

jx get activities \
    --filter go-demo-6 \
    --watch

jx get applications --env staging

GH_USER=[...]

open "https://github.com/$GH_USER/go-demo-6/releases"

echo "A silly change" | tee README.md

git add .

git commit \
    --message "A silly change"

git push

jx get activity \
    --filter go-demo-6 \
    --watch

cd ..

GH_USER=[...]

hub delete -y \
  $GH_USER/environment-jx-rocks-staging

hub delete -y \
  $GH_USER/environment-jx-rocks-production

rm -rf environment-jx-rocks-production

rm -rf ~/.jx/environments/$GH_USER/environment-jx-rocks-*
