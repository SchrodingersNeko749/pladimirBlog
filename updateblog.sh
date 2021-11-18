#!/bin/bash

JEKYLL_ENV=production bundle exec jekyll build
git add . && git commit -m 'onFileChangeHook' && git push
rsync -aAX0PH -e "ssh -o Compression=no" _site ubuntu@pladimirvutin.her.st:/home/ubuntu/Server
echo "done!"
