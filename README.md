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

# References
https://overthewire.org/wargames/bandit/
