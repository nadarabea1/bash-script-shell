#! /usr/bin/bash
dir="/home/nadarabea/FinalProject"


function Insert() {
        read -p "Enter Table Name : " tab
        if [ -d $dir/$conn/$tab ]
        then
                schema_file="$dir/$conn/$tab/schema"
                data_file="$dir/$conn/$tab/data"


                read -p "Enter the primary key value to Insert: " pk_value


                if grep -q "^$pk_value" "$data_file"
                then
                        echo "Record with primary key '$pk_value' already exists. Insertion aborted."
                        return
                fi


                columns=$(grep "Columns:" "$schema_file" | cut -d ':' -f 2)
                datatypes=$(grep "Datatypes:" "$schema_file" | cut -d ':' -f 2)
                primary_key=$(grep "Primarykey:" "$schema_file" | cut -d ':' -f 2)


                declare -A column_values
                declare -A Value_array

                IFS=',' read -ra column_array <<< "$columns"
                IFS=',' read -ra datatype_array <<< "$datatypes"

                for ((i = 0; i < ${#column_array[@]}; i++))
                do
                        column="${column_array[$i]}"
                        datatype="${datatype_array[$i]}"

                        read -p "Enter value for $column ($datatype): " value

                        case $datatype in
                                "int")
                                        if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                                                echo "Invalid input for $column. Must be an integer."
                                                return
                                        fi
                                        ;;
                                "string")
                                        ;;
                                *)
                                        echo "Unsupported data type: $data_type"
                                        return
                                        ;;
                        esac

                        values_array+=("$value")
                done

                values_str=$(IFS=" " ; echo "${values_array[*]}")

                echo "$values_str" >> "$data_file"
                values_array=()

                echo "Record inserted successfully."
        else
                echo not found '$tab' table
        fi
}


function Update() {
    read -p "Enter the table name: " tab

    if [ -d "$dir/$conn/$tab" ]; then
        read -p "Enter the primary key value to update: " pk_value

	schema_file="$dir/$conn/$tab/schema"

        if grep -q "^$pk_value " "$dir/$conn/$tab/data"; then
		columns=$(grep "Columns:" "$schema_file" | cut -d ':' -f 2)
                datatypes=$(grep "Datatypes:" "$schema_file" | cut -d ':' -f 2)


		declare -A column_values
		declare -A row

                IFS=',' read -ra column_array <<< "$columns"
                IFS=',' read -ra datatype_array <<< "$datatypes"
                for ((i = 0; i < ${#column_array[@]}; i++)); do
                        column="${column_array[$i]}"
                        datatype="${datatype_array[$i]}"

                        read -p "Enter value for $column ($datatype): " value


                case $datatype in
                    int)
                        if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                            echo "Invalid value for $column. Expected $datatype."
                            return
                        fi
                        ;;
                    string)
                        ;;
                    *)
                        echo "Unknown data type: $coltype."
                        return
                        ;;
                esac
                row["$column"]=$value
            done

	    
            sed -i "s/^$pk_value .*/${row[*]}/" "$dir/$conn/$tab/data"
            echo "Row updated successfully."
        else
            echo "Record with primary key '$pk_value' does not exist."
        fi
    else
        echo "Table '$tab' does not exist."
    fi
}

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