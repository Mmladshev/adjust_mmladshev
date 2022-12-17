## Description

```sh
Scrip prints numbers from 1 to 10 in random order. Scrip does not allos additional input from user, everything is hardcoded.
Added simple error handling for nonexisting flags.

You can use *adjtst* without any additional flags, to print simple output 
```


## Build instructions
```sh
git clone git@github.com:Mmladshev/adjust_mmladshev.git
cd /adjust_mmladshev/task1
chmod +x script.sh  
ln /path/to/the/script /usr/bin/adjtst
```

## Available options

```sh
adjtst --help

  -r          Print normal output and revert output
  -f          Print output inside /tmp/myscriptoutput
  --help      Display this help and exit
  --version   Output version information and exit

Also available from bash 
```