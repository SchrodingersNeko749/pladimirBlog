---
layout: post
title:  "Starting hacking web apps? Where to practice?"
date:   2021-11-17 20:17:21 +0330
categories: jekyll update
---
In this blog, I try to practice hacking web apps using a dummy website. I downloaded bWAPP (buggy web app) which is a webapp purposefully designed to be exploited. They are for security enthusiasts and webdev students to practice common security topics. To set it up I have to setup my own homeserver with nginx.Basically put them on localhost and do all nasty stuff with it without being scared of any legal backlash.

## Setting up nginx and php

In the bWAPP guide after doing basic configuration we are told to navigate to a php page so we can install bwAPP. My first problem was that when I navigated to any php page instead of viewing it in browser I download the file . I quickly understood that this is because of the simple reason that I never configured php for nginx. On arch I had to download two packages: `php-fpm` and `php`. 
Then I tried configuring nginx and php-fpm following the guide and eventho I followed all settings I couldnt get it to load a php page. which for that I had to debug using `systemctl status nginx.services` to see what's wrong. And the error mentioned that I never setup mysql which is needed for this webapp. I set that up and now I'm having another problem. I get ```Connection failed: Access denied for user 'root'@'localhost'``` which means there is an authentication problem going on. I looked deeper into it and realized root user doesn't have full privilege and to solve that I `drop` the root and `create` another user and grant all privileges to it. `drop` step isn't really necessary but I wanted to interact with
```
CREATE USER 'bwapp@localhost` IDENTIFIED BY 'some_pass';
GRANT ALL PRIVILEGES on bwapp.* to 'bwapp'@'localhost';
FLUSH PRIVILEGES;
```
And voila we now can try hacking stuff.
In next blog I will focus on practicing HTML injection vulnerability.