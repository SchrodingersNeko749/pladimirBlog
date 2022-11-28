#!/bin/bash

JEKYLL_ENV=production bundle exec jekyll build
git add . && git commit -m 'onFileChangeHook' && git push
rsync -aAX0PH -e "ssh -p 10422 -o Compression=no" _site ubuntu@pladimirvutin.her.st:/root/pladimirBlog
echo "done!"
