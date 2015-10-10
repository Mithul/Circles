#!/bin/bash
#Purpose = Backup of Important Data
#Created on 17-1-2012
#Author = Hafiz Haider
#Version 1.0
#START
TIME=`date +%b-%d-%y_%H:%M`            
FILENAME=backup-$TIME.tar.gz    
SRCDIR='/home/mithul/Circles/db'                  
DESDIR='/home/mithul/Circles/dbbackup'
echo 'tar -cpzf '$DESDIR'/'$FILENAME' '$SRCDIR
tar -cpzf $DESDIR/$FILENAME $SRCDIR

#END
