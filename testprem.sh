#!/bin/bash

if [ $# -ne 2 ]
then
echo "must provide two command line arguments"
exit
fi
k=`expr length "$1"`
if [ $k -ne 3 ]
then
echo "First argument must be 3 digits long"
exit
fi
if [ ! -d "$2" ]; then
    echo "second argument is not a directory"
    exit
fi

if [ -f $2 ]
  then
    echo "second argument directory does not exist"
    exit
fi

#echo "$2"
testperm=$1
stringperm=""
testperm1=$testperm
while [ $testperm1 -gt 0 ] 2>/dev/null
do
	x=$(($testperm1%10))
	if [ ! "$x" -eq "$x" ] 2>/dev/null
	then
	  echo "invalid file permission in command line argument1"
		exit
	fi

	if [ $x -lt 0 -o $x -gt 7  ]
	then
   		echo "invalid file permission in command line argument2"
		exit
	fi
	if [ $x -eq 0 ]
	then
	y="---"
	fi
	if [ $x -eq 1 ]
	then
	y="--x"
	fi
	if [ $x -eq 2 ]
	then
	y="-w-"
	fi
	if [ $x -eq 3 ]
	then
	y="-wx"
	fi
	if [ $x -eq 4 ]
	then
	y="r--"
	fi
	if [ $x -eq 5 ]
	then
	y="r-x"
	fi
	if [ $x -eq 6 ]
	then
	y="rw-"
	fi
	if [ $x -eq 7 ]
	then
	y="rwx"
	fi
	stringperm="$y$stringperm"
	testperm1=$(($testperm1/10))
done
stringperm="-$stringperm"
echo $stringperm
for i in `ls $2`
 do 

c="$2"
c+='/'
c+="$i"
#echo $c

perm=$(stat -c %A $c)
if [ "$perm" == "$stringperm" ]
then
echo $i
fi
#echo "$perm"
 done
echo $?
