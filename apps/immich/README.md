git remote add upstream https://github.com/helmforgedev/charts.git
git fetch upstream
git checkout upstream/main -- charts/immich
git add charts/immich
git commit -m "chore: import immich chart from upstream"
git remote rm upstream
