#!/bin/bash
typeset -i numFields;
typeset -i recordnumber;
typeset -i num;
stringregex="[a-zA-Z]+"
integeregex="[0-9]+"
passwordregex="[a-zA-Z0-9]+"
emailregex="[a-zA-Z0-9]+@[a-z]+.com"
dateregex="[0-9][0-9]*+/[0-9][0-9]*+/[0-9][0-9][0-9][0-9]+"
flag2=false
flag=true
 echo "Database MENU : "
select opt2 in 'CREATE TABLE' 'LIST TABLES' 'DROP TABLE' 'SELECT FROM TABLE' 'INSERT INTO TABLE' 'DELETE FROM TABLE' 'BACK' 
do
 case $opt2 in
    'CREATE TABLE') 
        read -p "Enter the table name : " tName   
        if [ -z "$tName" ]
        then
            clear 
            echo "This field is required!"
        elif [[ $tName =~ ^[a-zA-Z]*$ ]]
         then
            tNameMeta=".${tName}metadata"
            if [ -f "$tNameMeta" ]
            then
                    clear
                    echo "tName table is already exist."
            else 
                read -p "Enter the Primary field : " field 
                if [ -z "$field" ]
                then 
                    clear
                    echo "This field is required!" 
                    break
                elif [[ $field =~ ^[a-zA-Z]*$ ]]
                then
                    flag2=true
                    numFields=0
                    num=0;
                    touch $tName 
                    touch $tNameMeta
                    echo -n $field >> $tNameMeta
                    numFields=$numFields+1
                    fieldsarray[$num]=$field
                    read -p "Enter the fields of the table : " field  
                    if [ -z "$field" ]
                    then 
                        clear
                        echo "This field is required!" 
                        break
                    elif [[ $field =~ ^[a-zA-Z]*$ ]]
                    then
                     flag2=true
                        while [[ "$field" ]]
                        do
                            fieldsarray[$num+1]=$field
                            numFields=$numFields+1
                            echo -n ':'$field >> $tNameMeta
                            num+=1
                            read -p "Enter the fields of the table : " field
                        done
                            clear
                    else    echo "must containes characters only"
                    fi
                fi
                echo ''>> $tNameMeta
                echo -n 'serial:' >> $tNameMeta
                for((i=2 ;i<=$numFields ;i++))
                    do
                    echo "Select the datatype of field ${fieldsarray[$i-1]} : "
                    select opt3 in 'Integer' 'Varchar' 'Password' 'Date' 'Email' 
                    do
                        case $opt3 in
                        'Integer') 
                            dataType=Integer
                            if [ "$i" == "$numFields" ]
                            then
                                echo -n $dataType >> $tNameMeta
                            else
                                echo -n $dataType':' >> $tNameMeta
                            fi    
                                break
                            ;;
                        'Varchar')
                            dataType=Varchar
                            if [ "$i" == "$numFields" ]
                            then
                                echo -n $dataType >> $tNameMeta
                            else
                                echo -n $dataType':' >> $tNameMeta
                            fi 
                                break
                            ;;
                        'Password')
                            dataType=Password
                            if [ "$i" == "$numFields" ]
                            then
                                echo -n $dataType >> $tNameMeta
                            else
                                echo -n $dataType':' >> $tNameMeta
                            fi 
                                break
                            ;;
                        'Date')
                            dataType=Date
                            if [ "$i" == "$numFields" ]
                            then
                                echo -n $dataType >> $tNameMeta
                            else
                                echo -n $dataType':' >> $tNameMeta
                            fi 
                                break
                            ;;
                        'Email')
                            dataType=Email
                            if [ "$i" == "$numFields" ]
                            then
                                echo -n $dataType >> $tNameMeta
                            else
                                echo -n $dataType':' >> $tNameMeta
                            fi 
                                break
                            ;;
                       
                        esac
                    done
                done  
            if [ "$flag2" = true ]
            then 
            clear            
            echo "TABLE $tName is successfully created."
            else
              rm  $tName
              rm  ".${tName}metadata"
              clear
              echo "TABLE $tName  doesn't be created."
             fi
           
            fi 
           else
             clear
             echo "must containes characters only"  
        fi
        
        ;;
    'LIST TABLES') 
        echo "ALL EXISTED TABLES : " 
        clear
        ls
        ;;
    'DROP TABLE')
        read -p "Enter the table name : " tName 
        if [ -z "$tName" ]
        then
            clear
            echo "This field is required!"
        else
            if [ -f "$tName" ]
                then 
                rm -i $tName
                rm -i ".${tName}metadata"
                if [ -f "$tName" ] || [ -f ".${tName}metadata" ] 
                then
                    clear
                    echo "Table $tName is failed to be deleted completly."
                else
                    clear
                    echo "Table $tName is successfully deleted."
                fi
                else  
                    clear
                    echo "$tName table is not exist."
            fi  
        fi
        ;;
      'SELECT FROM TABLE') 
            select pt in 'SELECT ALL RECORDS' 'SELECT ALL WITH NUMBERED RECORDS' 'SELECT RANGE OF RECORDS' 'SELECT SINGLE RECORD' 'BACK'
            do
                case $pt in
                'SELECT ALL RECORDS')
                read -p "Enter the table name : " tName  
                    if [ -z "$tName" ]
                    then
                        clear 
                        echo "This field is required." 
                    else
                        if [ -f "$tName" ]
                        then 
                            if [ -z "$tName" ]
                            then 
                                clear
                                echo "Table $tName is empty."
                                exit
                            else
                            clear
                            echo "All records in table $tName : "
                            cat $tName
                            fi
                        else
                        clear
                        echo "$tName table is not exist."
                        fi 
                    fi
                ;;
                'SELECT ALL WITH NUMBERED RECORDS')
                read -p "Enter the table name : " tName 
                if [ -z "$tName" ]
                then
                    clear 
                    echo "This field is required!"
                else
                    if [ -f "$tName" ]
                    then 
                        if [ -z "$tName" ]
                        then 
                            clear
                            echo "$tName Table is empty"
                        fi
                        clear
                        echo "All records in table $tName : "
                        terminal=`tty`
                        exec < $tName
                        count=1
                        while read line
                        do
                            echo $count.$line
                            count=`expr $count + 1`
                        done
                        exec < $terminal
                    else
                        clear
                        echo "$tName table is not exist."
                    fi
                fi
                ;;
                'SELECT RANGE OF RECORDS')
                read -p "Enter the table name : " tName  
                if [ -z "$tName" ]
                then
                    clear 
                    echo "This field is required!"
                else
                    if [ -f "$tName" ]
                    then
                        if [ -z "$tName" ]
                        then
                            clear 
                            echo "$tName table is empty"
                        else
                            read -p "Enter the PK you want to select from : " pk
                            read -p "Enter the PK you want to select to : " pk2
                            if [ -z "$pk" -o -z "$pk2" ] 
                            then
                                clear 
                                echo "This field is required!"
                            else
                                recordnumber=$(tail -n 1 $tName|cut -d: -f1) 
                                if [ $pk -le $recordnumber -a $pk2 -le $recordnumber ]
                                then
                                    clear
                                    echo "All records from PK $pk To PK $pk2 from Table $tName : "
                                    while [[ $pk -le $pk2 ]]; 
                                    do
                                        NR=$(awk 'BEGIN{FS=":"}{if ( $1 == "'$pk'" ) print NR}' $tName 2>>/dev/null)
                                        if [[ $NR == "" ]]; 
                                        then
                                           echo "Record $pk is already deleted!"
                                            ((pk++))
                                        else
                                            echo "Record with PK $pk from Table $tName : "
                                            echo $(awk 'BEGIN{FS=":";}{if ( NR == '$NR' ) print $0 }' $tName 2>>/dev/null)
                                            ((pk++))
                                        fi
                                    done
                                   
                                else
                                    clear
                                    echo "INVALID RANGE!"
                                fi
                            fi
                        fi
                    else
                        clear
                        echo "$tName table is not exist."
                    fi
                fi
                ;;
                'SELECT SINGLE RECORD')
                read -p "Enter the table name : " tName 
                if [ -z "$tName" ]
                then
                    clear 
                    echo "This field is required!"
                else
                    if [ -f "$tName" ]
                    then
                        if [ -z "$tName" ]
                        then 
                            clear
                            echo "$tName Table is empty"
                            exit
                        else
                            recordnumber=$(tail -n 1 $tName|cut -d: -f1) 
                            # echo $recordnumber
                            read -p "Enter the PK you want to select : " pk                      
                            if [ -z "$pk" ]
                            then
                                clear 
                                echo "This field is required!"
                            else
                                if [ $pk -le $recordnumber ]
                                then
                                        NR=$(awk 'BEGIN{FS=":"}{if ( $1 == "'$pk'" ) print NR}' $tName 2>>/dev/null)
                                        if [[ $NR == "" ]]; 
                                        then
                                            echo "Record $pk is already deleted!"
                                        else
                                            echo "Record with PK $pk from Table $tName : "
                                            echo $(awk 'BEGIN{FS=":";}{if ( NR == '$NR' ) print $0 }' $tName 2>>/dev/null)
                                        fi
                                else
                                    clear
                                    echo "INVALID RECORD NUMBER!"
                                fi
                            fi
                        fi
                    else
                        clear
                        echo "$tName table is not exist."  
                    fi
                fi
                ;;
                'BACK')
                    echo "You are back to database menu! "
                    break
                ;;
                *)  
                    clear
                    echo "Please Select A Valid Option!" 
                ;;
                esac
            done
        ;;


    'INSERT INTO TABLE')
        read -p "Enter name of table " tName   
        if [ -z "$tName" ]
        then
            clear 
            echo "This field is required!"
        else
            if [ -f "$tName" ]
            then
                if [ -s $tName ]; 
                then
                    recordnumber=$(tail -n 1 $tName|cut -d: -f1) 
                    recordnumber=$recordnumber+1
                    echo  -n $recordnumber':'  >> $tName
                else
                    recordnumber=1   
                    echo  -n $recordnumber':'  >> $tName 
                fi
                numFields=$(awk -F: '{numFields = NF}END { print numFields } '<".${tName}metadata")
                for((i=2 ;i<=$numFields;i++))
                do
                    # echo $flag
                    read -p "Enter the $(head -n 1 ".${tName}metadata"|cut -d: -f$i) " data  
                    echo "$(tail -n 1 ".${tName}metadata"|cut -d: -f$i) " 
                    
                    # flag=true
                    case $(tail -n 1 ".${tName}metadata"|cut -d: -f$i)  in
                    'Varchar')
                        [[ $data =~ ^[a-zA-Z]*$ ]] &&  flag=true || i=$i-1 flag=false
                     ;;
                    'Integer')
                        [[ $data =~ ^[0-9]+$ ]] && flag=true || i=$i-1 flag=false
                     ;;
                    'Date')
                        [[ $data =~ ^[0-9][0-9]*+/[0-9][0-9]*+/[0-9][0-9][0-9][0-9]+$ ]] && flag=true || i=$i-1 flag=false
                     ;;
                    'Email')
                        [[ $data =~ ^[a-zA-Z0-9]+@[a-z]+.[a-z]{2,3}$ ]] && flag=true || i=$i-1 flag=false
                     ;;
                    'Password')
                        [[ $data =~ ^[a-zA-Z0-9]+$ ]] && flag=true || i=$i-1 flag=false
                     ;;
                    *)
                        clear
                        echo "end of data validation"  
                 ;;
                  esac
          

                    if [ -z "$data" ]
                    then
                        clear 
                        echo "This field is required!"
                    if [ "$flag" = true ]
                    then
                        i=$i-1
                    fi
                    else
                        if [ "$flag" = false ]
                        then
                        continue
                        else
                            if [ "$i" == "$numFields" ]
                            then
                            echo -n $data >> $tName
                            else
                            echo -n $data':' >> $tName
                            fi
                        fi
                    fi
                done 
                echo ''>> $tName
            else
                clear
                echo "$tName table is not exist."  
            fi
        fi
        ;;
     'DELETE FROM TABLE')
            select del in 'DELETE ALL RECORDS' 'DELETE RANGE OF RECORDS' 'DELETE A SINGLE RECORD' 'BACK'
            do
                case $del in
                'DELETE ALL RECORDS')
                read -p "Enter the table name : " tName 
                if [ -z "$tName" ]
                then
                    clear 
                    echo "This field is required!"
                else
                    if [ -f "$tName" ]
                    then 
                        if [ -z "$tName" ]
                        then 
                            clear
                            echo "$tName is empty."
                        else
                        sed -i '/^/d' $tName
                        clear
                        echo "All records in table $tName is successfully deleted."
                        fi
                    else
                    clear
                    echo "$tName table is not exist."
                    fi 
                fi
                ;;
                'DELETE RANGE OF RECORDS')
                read -p "Enter the table name : " tName  
                if [ -z "$tName" ]
                then
                    clear 
                    echo "This field is required!"
                else
                    if [ -f "$tName" ]
                    then
                        if [ -z "$tName" ]
                        then
                            clear 
                            echo "$tName is empty"
                        else
                            read -p "Enter the record number you want to select from " pk
                            read -p "Enter the record number you want to select to " pk2
                            if [ -z "$pk" -o -z "$pk2" ] 
                            then
                                clear 
                                echo "This field is required!"
                            else
                                recordnumber=$(tail -n 1 $tName|cut -d: -f1) 
                                if [ $pk -le $recordnumber -a $pk2 -le $recordnumber ]
                                then
                                    while [[ $pk -le $pk2 ]]; 
                                    do
                                        check=$(awk 'BEGIN{FS=":"}{if ( $1 == "'$pk'" ) print $1 }' $tName 2>>/dev/null)
                                        if [[ $check == "" ]]; 
                                        then
                                            echo "Record $pk is already deleted!"
                                            ((pk++))
                                        else
                                            NR=$(awk 'BEGIN{FS=":"}{if ( $1 == "'$pk'" ) print NR}' $tName 2>>/dev/null)
                                            sed -i ''$NR'd' $tName 2>>/dev/null
                                            echo "The record with PK $pk from table $tName is successfully deleted."
                                            ((pk++))
                                        fi
                                    done
                                else
                                    clear
                                    echo "INVALID RANGE!"
                                fi
                            fi
                        fi
                    else
                        clear
                        echo "$tName table is not exist."
                    fi
                fi
                ;;
                'DELETE A SINGLE RECORD')
                read -p "Enter name of table " tName 
                if [ -z "$tName" ]
                then
                    clear 
                    echo "This field is required!"
                else
                    if [ -f "$tName" ]
                    then
                        if [ -z "$tName" ]
                        then
                            clear 
                            echo "$tName is empty"
                        else
                            read -p "Enter PK of the record you want to delete : " pk 
                            if [ -z "$pk" ]
                            then
                                clear 
                                echo "This field is required!"
                            else
                                recordnumber=$(tail -n 1 $tName|cut -d: -f1) 
                                if [ $pk -le $recordnumber ]
                                then
                                       NR=$(awk 'BEGIN{FS=":"}{if ( $1 == "'$pk'" ) print NR}' $tName 2>>/dev/null)
                                        if [[ $NR == "" ]]; 
                                        then
                                            echo "Record $pk is already deleted!"
                                        else
                                            sed -i ''$NR'd' $tName 2>>/dev/null
                                            echo "The record with PK $pk in table $tName is successfully deleted."
                                        fi
                                else
                                    clear
                                    echo "Record is not found."
                                fi
                            fi
                        fi
                    else
                        clear
                        echo "$tName table is not exist."  
                    fi
                fi
                ;;
                'BACK')
                    clear
                    echo "You are back to database menu! "
                    break
                ;;
                *) 
                    clear
                    echo "Please Select A Valid Option!" 
                ;;
            esac
            done                
        ;;
    'BACK') 
        clear
        echo "YOU ARE BACK TO THE MAIN MENU!"
        break 
        ;;
    *) 
        clear
        echo "Please Select A Valid Option!" ;;
    esac 
done
