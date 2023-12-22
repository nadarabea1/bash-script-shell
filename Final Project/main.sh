#! /usr/bin/bash

dir="/home/nadarabea/FinalProject"

function DropTable() {
        read -p "Enter the Name of Table : " tab
        if [ -d $dir/$conn/$tab ]
        then
                read -p "Are you Sure? (Y | N)" ans
                if [ $ans == 'Y' ] || [ $ans == 'y' ]
                then
                        rm $dir/$conn/$tab
                        echo "Table '$tab' dropped successfully."
                fi
        else
                echo "Not found '$tab' table"
        fi
}

function ListTable() {
        ls  $dir/$conn
}

function CreateTable() {
	read -p "Enter the table name: " tab
	if [  -d $dir/$conn/$tab ]
	then
		echo Table $tab exists
	else
        	read -p "Enter the columns (comma-separated, e.g., col1,col2,col3): " cols
		read -p "Enter the data types for each column (comma-separated, e.g., int,string): " datatypes
		read -p "Enter the primary key: "  pk
		mkdir $dir/$conn/$tab 
		touch $dir/$conn/$tab/schema
		touch $dir/$conn/$tab/data
		echo "Columns:$cols" > "$dir/$conn/$tab/schema"
		echo "Datatypes:$datatypes" >> "$dir/$conn/$tab/schema"
		echo "Primarykey:$pk" >> "$dir/$conn/$tab/schema"

		echo "Table '$tab' created successfully."
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
                echo "DB '$crt' created successfully"
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
                        echo "DB '$drop' dropped successfully."                
                fi

        else
                echo Not Found DB!
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