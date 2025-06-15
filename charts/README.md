# Helm Charts management

In order to manage the Helm charts, and be able to select specific versions per environment, we're going to use the
official Helm releaser tool.

First we need to create an orphan branch usually located in gh-pages branch, and then we can use the `helm-releaser`
tool to manage the Helm charts. For that execute the following commands:

I recommend to use a new isolated temporal checkout of the repository to avoid any issues with the current branch.

```bash
git checkout --orphan gh-pages
git reset --hard # to remove all files
git commit --allow-empty -m "Initial commit for Helm charts"
git push origin gh-pages
```

Then we need a workflow that use helm releaser over the charts directory. Check the helm-releaser.yaml file in the
`.github/workflows` directory.
