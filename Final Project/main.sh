#! /usr/bin/bash

dir="/home/nadarabea/FinalProject"

function Select() {
	read -p "Enter Table Name: " tab
	if [ -d $dir/$conn/$tab ]
	then
		select choice in "Select by Column" "Select by Row" "Select All"
                	do
                        	case $choice in
                                	"Select by Column") SelectByCol $tab	
						;;
					"Select by Row") SelectByRow $tab
						;;
					"Select All")
						cat $dir/$conn/$tab/data
						;;
					*) break
                        	esac
        	done
	else 
		echo No found Table
	fi

}

function Delete() {
	read -p "Enter the table name: " tab

	if [ -d "$dir/$conn/$tab" ]; then
		read -p "Enter the primary key value to delete: " pk_value
		if grep -q "^$pk_value " "$dir/$conn/$tab/data"; then
			sed -i "/^$pk_value /d" "$dir/$conn/$tab/data"
			echo "Row deleted successfully."
		else
		       	echo "Record with primary key '$pk_value' does not exist."
		fi
	else
		echo "Table '$tab' does not exist."
	fi
}

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

function Connect() {
	read -p "Enter Name of DB you to connect : " conn;
	if [ -d "$dir/$conn" ]
	then
		
		select choice in "Create Table" "List Tables" "Drop Table" "Insert" "Select from Table" "Delete" "Update"
		do
			case $choice in 
				"Create Table")CreateTable
					;;
				"List Tables") ListTable
					;;
				"Drop Table") DropTable
					;;
				"Insert") Insert
					;;
				"Select from Table") Select
					;;
				"Delete") Delete
					;;
				"Update") Update
					;;
				*)break
					;;
			esac

		done
	else 
		echo Not found DB!
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