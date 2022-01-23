#!/bin/bash
echo "MAIN MENU : "
select opt1 in 'CREATE DATABASE' 'LIST DATABASE' 'CONNECT TO DATABASE' 'DELETE DATABASE' 'EXIT' 
do
 case $opt1 in
            'CREATE DATABASE') 
                read -p "Enter the database name : " dbName 
                if [ -z "$dbName" ]  
                then
                    clear 
                    echo "This field is required!"
                else
                    if [[ $dbName =~ ^[a-zA-Z]*$ ]]   
                    then 
                        if [[ "$PWD" = *bashProject ]] 
                        then
                            if [ -d "$dbName" ]   
                            then
                                clear 
                                echo "$dbName database is already exist."
                            else  
                            mkdir $dbName
                            cp ./.connect.sh ./$dbName/.$dbName.sh
                            clear
                            echo "DATABASE $dbName is successfully created."
                            fi 
                        else
                        cd ..
                            if [ -d "$dbName" ]  
                            then
                                clear 
                                echo "$dbName database is already exist."
                            else  
                            mkdir $dbName
                            cp ./.connect.sh ./$dbName/.$dbName.sh
                            clear
                            echo "DATABASE $dbName is successfully created."
                            fi   
                        fi  
                    else
                    clear
                    echo "must containes characters only"
                    fi 
                fi
                ;;
            'LIST DATABASE') 
                echo "ALL EXISTED DATABASES : " 
                if [[ "$PWD" = *bashProject ]]
                then
                    clear
                    ls 
                else
                    cd ..
                    clear
                    ls 
                fi
                ;;
            'CONNECT TO DATABASE') 
                read -p "Enter the database name : " dbName
                if [ -z "$dbName" ]
                then
                    clear 
                    echo "This field is required!"
                else
                    if [[ "$PWD" = *bashProject ]]
                    then
                        if [ -d "$dbName" ]
                            then
                                clear 
                                echo "DATABASE $dbName is successfully connected."
                                cd $dbName
                                source "${PWD}/.$dbName.sh"
                            else
                            clear  
                            echo "$dbName database is not exist."
                        fi 
                    else
                        cd ..
                        if [ -d "$dbName" ]
                            then 
                                clear
                                echo "DATABASE $dbName is successfully connected."
                                cd $dbName
                                source "${PWD}/.$dbName.sh"
                            else
                                clear  
                                echo "$dbName database is not exist."
                        fi
                    fi
                fi
                ;;
            'DELETE DATABASE') 
                read -p "Enter the database name : " dbName
                if [ -z "$dbName" ]
                then
                    clear 
                    echo "This field is required!"
                else
                    if [[ "$PWD" = *bashProject ]]
                    then
                        if [ -d "$dbName" ]
                            then 
                            rm -r -i $dbName
                            if [ -d "$dbName" ]
                            then
                                clear 
                                echo "DATABASE $dbName failed to be deleted." 
                            else
                                clear 
                                echo "DATABASE $dbName is successfully deleted." 
                            fi
                        else  
                            clear
                            echo "$dbName database is not exist."
                        fi 
                    else
                        cd ..
                        if [ -d "$dbName" ]
                            then 
                            rm -r -i $dbName
                            clear
                            echo "DATABASE $dbName is successfully deleted." 
                            else 
                            clear 
                            echo "$dbName database is not exist."
                        fi 
                    fi
                fi
                ;;
            'EXIT') 
                clear
                echo "EXIT!"
                break 
                ;;
            *)
                clear 
                echo "Please Select A Valid Option!" ;;
        esac 
done