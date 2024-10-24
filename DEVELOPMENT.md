# Update submodules after a `git pull` in the main repository: 

After doing a `git pull` in the main repository, you can update the submodules to the recorded versions: 

```
git pull origin main
git submodule update --recursive --remote
```
note: git 1.8.2 or above 

 