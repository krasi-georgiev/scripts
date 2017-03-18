#!/bin/bash
dir=$1

for i in `find $dir -name *.ibd.bak`  
do  
  #sudo rm $i
  echo "Repairing $i"
  sudo mv $i $i.bak
  sudo cp -a $i.bak $i
  sudo rm $i.bak
done 
