! /usr/bin/bash

function CreateDB {
read -p "Enter Name of DB: " db
mkdir "/home/nada/FinalProject/$db"
suboptions=("Create file" "Insert" "Update" "Select")
select choice in "${suboptions[@]}"
do
case $choice in
"Create file") echo Create
;;
"Insert") echo List
;;
"Update") echo Connect
;;
"Select") echo Select
;;
*) break
esac
done
}

options=("Create DB" "List DB" "Connect DB" "Exit")
select choice in "${options[@]}"
do
case $choice in
"Create DB") CreateDB ; echo $?
;;