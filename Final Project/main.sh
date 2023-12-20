#! /usr/bin/bash

dir="/home/nadarabea/FinalProject"

function DropTable() {
        read -p "Enter the Name of Table : " tab
        if [ -f $dir/$conn/$tab ]
        then
                read -p "Are you Sure? (Y | N)" ans
                if [ $ans=='Y' ] || [ $ans=='y' ]
                then
                        rm $dir/$conn/$tab
                        echo Table was Dropped
                fi
        else
                echo NO Such Table
        fi
}

function ListTable() {
        ls  $dir/$conn
}

function CreateTable() {
        read -p "Enter Table Name: " tab
        declare -a "$tab"=""
        if [ -f $dir/$conn/$tab ]
        then
                echo "There is Table with the same name ;( "
        else
                touch $dir/$conn/$tab
                echo "Table Created ;) "        




                read -p "Enter the number of colums : " cols
                printf '#' > $dir/$conn/$tab
                ans='n'
                for ((i=1; i<=$cols; i++))
                do
                        read -p "Enter Name of Colum $i: " name
                        colArr+=("$name")
                        read -p "Enter Data type(int | string | bool): " dtype
                        if [ $ans == 'n' ] || [ $ans == 'N' ]
                        then
                                read -p "Is primary key (Y|N)? " ans
                                if [ $ans == 'Y' ] || [ $ans == 'y' ]
                                then
                                        name=$name*
                                fi
                        fi

                        printf $name-$dtype: >> $dir/$conn/$tab
                done

                printf '\n' >> $dir/$conn/$tab

        fi

}
function List() {
        ls -R $dir
}
function CreateDB() {
        read -p "Enter Name of DB: " crt
        if [ -d $dir/$db/$crt ]
        then
                read -p "Enter another name of DB: " crt
        else
                mkdir $dir/$crt
        fi

}
function Drop() {
        read -p "Enter Name of DB you want to drop: " drop
        if [ -d "$dir/$drop" ]
        then
                read -p "Are you Sure? (Y | N) " ans
                if [ $ans == "Y" ] || [ $ans == "y" ]
                then
                        rm -R $dir/$drop
                        echo "Drop $drop DB"
                fi

        else
                echo NO Found DB!
        fi
}




select choice in "Create DB" "List DB" "Connect DB" "Drop DB" ;do
        case $choice in
                "Create DB") CreateDB
                        ;;
                "List DB")  List
                        ;;
                "Connect DB")  Connect
                        ;;
                "Drop DB")  Drop
                        ;;
                *)exit
        esac
done

~                                                                                                                             
~                                                                                                                             
~