#!/bin/bash
echo "MAIN MENU : "
select opt1 in 'CREATE DATABASE' 'LIST DATABASE' 'CONNECT TO DATABASE' 'DELETE DATABASE' 'EXIT' 
do
 case $opt1 in
            'CREATE DATABASE') 
                read -p "Enter the database name : " dbName
                if [ -z "$dbName" ]
                then echo "This field is required!"
                else
                    if [[ "$PWD" = *bashProject ]]
                    then
                    if [ -d "$dbName" ]
                        then echo "$dbName database is already exist."
                        else  
                        mkdir $dbName
                        cp ./.connect.sh ./$dbName/.$dbName.sh
                        echo "DATABASE $dbName is successfully created."
                        fi 
                    else
                    cd ..
                    if [ -d "$dbName" ]
                        then echo "$dbName database is already exist."
                        else  
                        mkdir $dbName
                        cp ./.connect.sh ./$dbName/.$dbName.sh
                        echo "DATABASE $dbName is successfully created."
                        fi  
                    fi
                  fi  
                ;;
            'LIST DATABASE') 
                echo "ALL EXISTED DATABASES : " 
                if [[ "$PWD" = *bashProject ]]
                then
                ls 
                else
                cd ..
                ls 
                fi
                ;;
            'CONNECT TO DATABASE') 
                read -p "Enter the database name : " dbName
                if [ -z "$dbName" ]
                then echo "This field is required!"
                else
                    if [[ "$PWD" = *bashProject ]]
                    then
                        if [ -d "$dbName" ]
                            then 
                            echo "DATABASE $dbName is successfully connected."
                            cd $dbName
                            source "${PWD}/.$dbName.sh"
                            else  
                            echo "$dbName database is not exist."
                        fi 
                    else
                        cd ..
                        if [ -d "$dbName" ]
                            then 
                            echo "DATABASE $dbName is successfully connected."
                            cd $dbName
                            source "${PWD}/.$dbName.sh"
                            else  
                            echo "$dbName database is not exist."
                        fi
                    fi
                fi
                ;;
            'DELETE DATABASE') 
                read -p "Enter the database name : " dbName
                if [ -z "$dbName" ]
                then echo "This field is required!"
                else
                    if [[ "$PWD" = *bashProject ]]
                    then
                        if [ -d "$dbName" ]
                            then 
                            rm -r -i $dbName
                            echo "DATABASE $dbName is successfully deleted." 
                            else  
                            echo "$dbName database is not exist."
                        fi 
                    else
                        cd ..
                        if [ -d "$dbName" ]
                            then 
                            rm -r -i $dbName
                            echo "DATABASE $dbName is successfully deleted." 
                            else  
                            echo "$dbName database is not exist."
                        fi 
                    fi
                fi
                ;;
            'EXIT') 
                echo "EXIT!"
                break 
                ;;
            *) echo "Please Select A Valid Option!" ;;
        esac 
done