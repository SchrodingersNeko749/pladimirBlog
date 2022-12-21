---
layout: post
title:  "Network interface and namespace"
date:   2022-11-28 18:20:21 +0330
categories: jekyll update
tags: 
   network
---
## A familiar word

No matter you have been configuring your network, a container, or just reading random blogs on internet you have heard this word.

## What exactly is it then

If you type `ifconfig` or `ip a` in your terminal you will see block(s) of information in which there are words like `lo`, `wlp3s0`, `wireguard`, `eth0`. these are called network interfaces.
These interfaces can be either physical, which means they are connected to a network adaptor like eth0 or wlp3s0, or completely virtual like loopback or wireguard.
While this information might make some satisfied we need to ask some fundumental questions to get a little bit more out of it.

## lets say you dont have a network interface

What happens when let's say you delete all the interfaces in your `ifconfig`?

Then you wont be able to connect to any other computer, or even to your own computer!
One of the interfaces is called `lo` or loopback. `lo` is a virtual interface because as opposed to physical. If you have any experience with web development you have probably tested your website on localhost. You basically get packets from your computer in form of http requests and then send packets back to your own computer.

So we can try this out without wrecking our computer's network. We are going to make a network namespace which tldr is a seperate space or room in your operating system that does not use the same networking rules. Then we are going to add `lo` interface to it and then host a server on it!

```
$ sudo ip netns add ns1
$ sudo ip netns exec ns1 bash # creates a shell in the namespace
[root@antarctica neko] ifconfig
> (no output) # means there are no interfaces
```
notice that we have executed bash on the namespace to be able to interact with our namespace.

Now lets make a nameserver and try to connect to it.

```
$ nc -lnvp 8900 &
$ netstat -tulpn
> Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:42233           0.0.0.0:*               LISTEN      2499724/nc  
$ curl localhost:8900/index.html 
```

As you can see, there is a server as shown in netstat but it wont send/get any packets because there are no interfaces.

## How to add network interface
We can use ip link to set up a loopback interface. As mentioned before it allows us to send packet to our computer which is preciesly what we want to do

```
$ ip link set dev lo up
$ ifconfig
> lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 12  bytes 720 (720.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 12  bytes 720 (720.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
$ curl localhost:8900
> Connection from 127.0.0.1:49636
GET / HTTP/1.1
Host: localhost:8900
User-Agent: curl/7.86.0
Accept: */*
```
And here it is! The netcat server recieved a connection from port 49636.
