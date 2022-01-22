#!/bin/bash
echo "MAIN MENU : "
select opt1 in 'CREATE DATABASE' 'LIST DATABASE' 'CONNECT TO DATABASE' 'DELETE DATABASE' 'EXIT' 
do
 case $opt1 in
            'CREATE DATABASE') 
                read -p "Enter the database name : " dbName
                if [ -z "$dbName" ]
                then echo "This field is required!"
                elif [[ $dbName =~ ^[a-zA-Z]*$ ]]
                then 
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
                else
                echo "must containes characters only"

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
                            if [ -d "$dbName" ]
                            then echo "DATABASE $dbName failed to be deleted." 
                            else echo "DATABASE $dbName is successfully deleted." 
                            fi
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