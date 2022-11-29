#!/bin/bash

JEKYLL_ENV=production bundle exec jekyll build
git add . && git commit -m 'onFileChangeHook' && git push
rsync -aAX0PH -e "ssh -p 10422 -o Compression=no" _site root@eu1.her.st:/srv/neko.her.st
scp -r _site/* neko@box.alumni.re:/neko.her.st
echo "done!"
