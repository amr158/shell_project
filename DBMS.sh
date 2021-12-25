#!/bin/bash
PS3="select one of the above : "
select choice in "Create Database" "List Databases" "Connect to Database" "Drop Database" "Exit"
do
       case $choice in
	       "Create Database") 
		       echo "enter database name : "
		       read name
		       . scripts/naming_check.sh $name
		       val="valid"
		       if [[ $res == $val ]]
		       then
			       val=databases/$name
			       if [ -d $val ] 
			       then
                                       echo database already exists
			       else
				       mkdir $val
				       echo $name database created successfully
                               fi
		       fi
		       ;;
	       "List Databases") ls databases
		       ;;
	       "Connect to Database") 
		       echo "enter database name : "
                       read name
                       . scripts/naming_check.sh $name
                       val="valid"
                       if [[ $res == $val ]]
                       then
                               val=databases/$name
                               if [ -d $val ]
                               then
                                       cd $val
				       break
                               else
                                       echo $name does not exist
                               fi
                       fi
		       ;;
	       "Drop Database") 
		       echo "enter database name : "
                       read name
                       . scripts/naming_check.sh $name
                       val="valid"
                       if [[ $res == $val ]]
                       then
                               val=databases/$name
                               if [ -d $val ]
                               then
                                       rm -r $val
				       echo $name droped successfully
                               else
                                       echo $name does not exist
                               fi
                       fi
		       ;;
	       "Exit")
		       break ;;
	       *) echo $choice is not a valid choice
		       ;;
       esac
       done

	       
