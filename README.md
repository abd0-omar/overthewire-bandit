# overthewire

## lvl 4
```bash
for i in $(ls); do file_info=$(file ./$i); echo "$file_info" | grep "ASCII text"; done
```
## lvl 5
```bash
for dir in $(ls); do for i in $(ls $dir); do file_info=$(file ./$dir/$i); echo "$file_info" | grep "ASCII text"; done; done
```
this won't work but it does only two levels deep in the directory, we must do it recursively

`ls -R` searches recursively
or even better `ls -alR`

simplest solution
```bash
bandit5@bandit:~/inhere$ find . -readable -size 1033c -not -executable
./maybehere07/.file2
```

## lvl 6
```bash
bandit6@bandit:/$ find / -user bandit7 -group bandit6 -size 33c 2>/dev/null
/var/lib/dpkg/info/bandit7.password
```
`2>/dev/null` removes all the error messages

## lvl 7
nice to know
```bash
wc -l data.txt
```
counts the number of lines
but the main question is simple
```bash
cat data.txt | grep "millionth"
```

# lvl 8
```bash
bandit8@bandit:~$ cat data.txt | sort | uniq -c | grep -v 10
```
`grep -v` to do not search for 10

simpler way
```bash
bandit8@bandit:~$ cat data.txt | sort | uniq -u
```

## lvl 9
```bash
strings data.txt | grep =
```
strings shows only the human readable data, grep = because the question said that it perceeding =s

## lvl 10
encoded base64 ends with two equal signs (\==)
```bash
cat data.txt | base64 -d 
```

## lvl 11
rot 13 algo, from any website, or by using vim `g?`

## lvl 12
commands used
```bash
cd /tmp
mktemp -d

cat data.txt | xxd -r > hexdump_file
# -r stands for reverse

file hexdump_file
mv hexdump_file hexdump_file.gz # or .bz2

gzip -d hexdump_file.gz #or bzip2 
# -d stands for decompress I think

# if the file is a tar file
tar -xvf 

file data 
```

## lvl 13
```bash
ssh -i ssh.private_key -p 2220 bandit14@localhost
```
`-i` attachs the private key to connect with ssh

## lvl 14
`nc` is used to make TCP, UDP connection between systems, and also used to listen for ports.
```bash
nc localhost 30000
<password of the last level>
```

## lvl 15
establish a secure connection to the server
```bash
openssl s_client -connect localhost:30001
```

## lvl 16
find open ports within range
```bash
nmap localhost -p 31000-32000
```

| PORT      | STATE | SERVICE     |
| --------- | ----- | ----------- |
| 31046/tcp | open  | unknown     |
| 31518/tcp | open  | unknown     |
| 31691/tcp | open  | unknown<br> |
| 31790/tcp | open  | unknown<br> |
| 31960/tcp | open  | unknown<br> |

see which one has ssl
```bash
nmap localhost -p 31046,31518,31691,31790,31960 -sV -T4
```

`-sV` to identify the service version
`-T4` makes a faster scan with `-T0` is the slowest and `-T5` is the fastest 

| PORT      | STATE | SERVICE     | VERSION |
| --------- | ----- | ----------- | ------- |
| 31046/tcp | open  | echo        |         |
| 31518/tcp | open  | ssl/echo    |         |
| 31691/tcp | open  | echo        |         |
| 31790/tcp | open  | ssl/unknown |         |
| 31960/tcp | open  | echo        |         |

the only two that has ssl are 31518,31790

31790 appears the one that we want as 31518 just echos back what we give it
```bash
openssl s_client -connect localhost:31790 -quiet
```

```
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----
```

```bash
mktemp -d
# it will make a dir with a random name, cd into the dir
touch rsa_key
vim rsa_key #and paste the rsa content to the file
chmod 600 rsa_key # to make only the user has read&write permissions in order to use ssh to the next level
ssh -i rsa_key bandit17@bandit.labs.overthewire.org -p 2220
```

# References
https://overthewire.org/wargames/bandit/
