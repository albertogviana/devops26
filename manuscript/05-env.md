## Hands-On Time

---

# GitOps With jx Env


## Exploring Environments

---

```bash
jx get env

jx get env -p Auto

jx get env -p Manual

jx get env -p Never
```


## Changing Staging Environment

---

```bash
cd ..

GH_USER=[...]

git clone https://github.com/$GH_USER/environment-jx-rocks-staging.git

cd environment-jx-rocks-staging

ls -l

cat Makefile

cat Jenkinsfile

ls -l env

cat env/requirements.yaml
```


## Changing Staging Environment

---

```bash
vim Jenkinsfile
```

* Add `--force=false` to `sh 'jx step helm apply'` in Jenkinsfile in environment repos

```bash
git add . && git commit -m "Added --force=false" && git push

jx get activity -f environment-jx-rocks-staging/master -w
```


## Changing Prod Environment

---

```bash
cd ..

git clone https://github.com/$GH_USER/environment-jx-rocks-production.git

cd environment-jx-rocks-production

vim Jenkinsfile
```

* Add `--force=false` to `sh 'jx step helm apply'` in Jenkinsfile in environment repos

```bash
git add . && git commit -m "Added --force=false" && git push

jx get activity -f environment-jx-rocks-production/master -w
```