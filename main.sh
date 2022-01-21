#! bin/bash
# _____ * _____Bash DBMS  _____ * _____ #

# _____ * _____AH DATABASE MANAGMENT SYSTEM  _____ * _____ #

# _____ * _____ MAIN SCRIPT  _____ * _____ #

# AHDB stands for => Ayman Hafez Data base

# Create the AHDB folder only if it's not exists
if [[ ! -d AHDB ]]
then
  mkdir ./AHDB 
fi
clear
echo "Welcome to AH-DBMS"
# calling the mainMenu Function in the end of the script
# _____ * _____ END OF MAIN SCRIPT  _____ * _____ #

# Create main Menu Function
function createMainMenu 
{
    echo "===========================================";
    echo -e "#_____ * _____ * Main Menu _____ * _____ #";
    
    echo "1) Create Database";
    echo "2) List Databases";
    echo "3) Connect To Databases";
    echo "4) Drop Database";
    echo "5) clear Screen"; 
    echo "6) Exit";
    echo "===========================================";
    echo -e "Please Enter your choice: \c"
    read ch
    case $ch in
      1)  createDB ;;
      2)  listDB ;;
      3)  connectToDB ;;
      4)  dropDB ;;
      5)  clearScreen ;;
      6)  exit ;;
      *)  echo "Please select a correct number from the given menu";createMainMenu;
    esac
}

# _____ * _____ Main Menu Functions  _____ * _____ #

# a function that create a database as a folder relative to the script
function createDB 
{
  echo -e "Please Enter the database name: \c";
  read dbName;
  
  if [[ -d ./AHDB/$dbName ]]
  then
    echo "$dbName already exists!!";
  else
    mkdir ./AHDB/$dbName 2>> ./.error.log
    if [[ $? == 0 ]]
    then
      echo "$dbName Database Created Successfully";
    else
      echo "Error Creating the database $dbName"; 
    fi
  fi
  createMainMenu;
}

# function to list the database
function listDB
{
  ls ./AHDB | awk '{ print ">>", $0 } 
    END {
      if (NR == 0)
        print ">> You have not created any database yet!!"
    }'
  createMainMenu;
}

#function to connect to the database
function connectToDB
{
  echo -e "Please Enter Database Name: \c";
  read dbName;
  cd ./AHDB/$dbName 2>>./.error.log
  if [[ $? == 0 ]]
  then
    echo "Successfully connected to $dbName database :)";
    createTableMenu $dbName;
  else
    echo "$dbName dosn't exists!";
    createMainMenu;
  fi
}

# a function that remove the database folder 
function dropDB 
{
  echo -e "Please Enter Database Name: \c";
  read dbName;
  rm -r ./AHDB/$dbName 2>> ./.error.log;
  if [[ $? == 0 ]]
  then
    echo "$dbName Dropped Successfully";
  else
    echo "$dbName dosn't exists!";
  fi
  createMainMenu;
}

#clear screen Function
function clearScreen
{
  clear;
  createMainMenu;
}
# _____ * _____ End of  Main Menu Functions  _____ * _____ #


# Create Table Menu Function
function createTableMenu
{
    echo "===========================================";
    echo -e "#____*____ * $1 Database Menu * ____*____ #";
    
    echo "01) Create Table";
    echo "02) List Tables";
    echo "03) Drop Table";
    echo "04) Insert Into Table";
    echo "05) Select From Table";
    echo "06) Delete From Table";
    echo "07) Update Table";
    echo "08) clear Screen"; 
    echo "09) Return to Main Menu";
    echo "10) Exit";
    echo "===========================================";
    echo -e "Please Enter your choice: \c"
    read ch
    case $ch in
      1)  createTable $1;;
      2)  listTables $1;;
      3)  dropTable $1;;
      4)  insertIntoTable $1;;
      5)  selectFromTable $1;;
      6)  deleteFromTable $1;;
      7)  updateTable $1;;
      8)  clearTableScreen $1;;
      9)  returnToMainMenu ;;
      10)  exit ;;
      *)  echo "Please select a correct number from the given menu";createMainMenu;
    esac
}

# _____ * _____ Table Menu Functions  _____ * _____ #

#a function that create a CSV file for the table 
function createTable
{
  # notes-from-project-instructions:
    # 1- Ask about columns datatypes in create table and check on them in both insert and update
    # 2- Ask about primary key in create table and check for it in the insert into table
  echo -e "Please Enter Table Name: \c";
  read tableName;
  if [[ -f $tableName ]]
  then
    echo "Sorry table already exists!!";
    createTableMenu $1;
  fi
  echo -e "Please Enter the Number of Columns"
  read numberOfColumns;
  i=1;
  separator=",";
  rowSeparator="\n";
  isPrimaryKey=0;
  tableMetaData="ColumnName"$separator"Data-Type"$separator"key";
  while [ $i -le $numberOfColumns ]
  do
    echo -e "Enter the Name of Column No $i: \c";
    read columnName;
    echo -e "Enter the dataType of Column $columnName: ";
    select answer in "integer" "string"
    do
      case $answer in
        integer ) dataType="INT"; break;;
        string ) dataType="STRNG"; break;;
        *) echo "Please Choose either Int nor string";
      esac
    done
    if [[ $isPrimaryKey == 0 ]]
    then
      echo -e "Do you want to make $columnName primaryKey? "
      select answer in "yes" "no"
      do
        case $answer in
          yes ) 
            isPrimaryKey=1;
            tableMetaData+=$rowSeparator$columnName$separator$dataType$separator"PRIMARY KEY"; break;;
          no )
            tableMetaData+=$rowSeparator$columnName$separator$dataType$separator""; break;;
          * ) echo "please choose either yes or no";
        esac
      done
    else
      tableMetaData+=$rowSeparator$columnName$separator$dataType$separator"";
    fi
    if [[ $i == $numberOfColumns ]]
    then
      tableActualData=$tableActualData$columnName
    else
      tableActualData=$tableActualData$columnName$separator
    fi
    ((i++))
  done
  touch .$tableName
  echo -e $tableMetaData >> .$tableName
  touch $tableName
  echo -e $tableActualData >> $tableName
  if [[ $? == 0 ]]
  then
    echo "Table $tableName Created Successfully";
    createTableMenu $1;
  else
    echo "Undetermine error occur during creating table $tableName";
    createTableMenu $1;
  fi
}

# a function that list the tables in the database directory
function listTables
{
  ls . | awk '{ print ">>", $0 } 
    END {
      if (NR == 0)
        print ">> You have not created any tables yet!!"
    }';
  createTableMenu $1;
}

function dropTable
{
  echo -e "Please Enter Table Name: \c";
  read tableName;
  if [[ -f $tableName ]]
  then
    rm -rf ./$tableName ./.$tableName 2>>./.error.log;
    if [[ $? == 0 ]]
    then
      echo "$tableName Table Dropped Successfuly";
    fi
  else
    echo "Their is no Table with this Name!!";
  fi
  createTableMenu $1;
}

# function insertIntoTable
# {
#   #todoSS
# }

# function selectFromTable
# {
#   # todo
#   # note-from-project-instructions:
#   # The Select of Rows displayed in screen/terminal in an Accepted/Good Format
# }

# function deleteFromTable
# {
#   #todo
# }

# function updateTable
# {
#   #todo
# }


# A function that return to the main menu
function returnToMainMenu
{
  clear;
  cd ../../ 2>>./.error.log;
  createMainMenu;
}

# A function that clear a table screen
function clearTableScreen
{
  clear;
  createTableMenu $1;
}
# _____ * _____ End of Table Menu Functions  _____ * _____ #


# calling the  main menu function that start the script 
createMainMenu;


# @ All rights reserved to Ayman - Hafez - ITI - OS Track - Intake 42;
