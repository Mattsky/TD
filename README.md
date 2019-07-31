# Teradici

This repo contains the following files:

bash/portcheck.sh (exercise 1)
bash/replace.sh (exercise 2)
bash/insert.sh (exercise 3)

python/wordcount.py (exercise 4)
python/github.py (exercise 5)

All scripts were created and tested on a Linux system. sed functionality may not work as intended on macOS due to differences in the tool on that platform.

## Installation

Clone the repo:
```sh
git clone https://github.com/Mattsky/TD.git
```
The bash scripts assume you're using bash v4.

You'll need Python 3 installed, with the requests library.
```sh
pip3 install requests
```

## Usage

### Bash Scripts
#### portcheck.sh

This script assumes TCP connections only (UDP checking is unreliable!) and that the remote host / IP address passed in is valid - the regex setup needed to check it would be pretty unwieldy. This writes results to output.txt in the script's directory.

```sh
./portcheck.sh <host> <port (range)>
e.g. 
./portcheck 127.0.0.1 80
./portcheck www.google.com 443
```

#### replace.sh

This script assumes you don't want to actually change the original file, and outputs amended data to the console.

Run the script with the required args - path to a file, the regex, and the replacement string to replace with the regex.

```sh
./replace.sh testfile.txt 'potato 5' avsdfsdfsdf
```

#### insert.sh

Run the script with the required args - string to insert, the incremental line number to insert the string on, and the filename. "testfile.txt" is provided as sample data.

```sh
./insert.sh potato 5 testfile.txt
```

### Python Scripts
#### wordcount.py

Run the script with a valid path to a text file as an argument. Two sample files are provided:
- wordfile1.txt
- wordfile2.txt

```sh
python3 wordcount.py /path/to/file
```

#### github.py

Simply run the script, and the output will be returned in the console.

```sh
python3 github.py
```
