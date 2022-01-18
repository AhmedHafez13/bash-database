#! bin/bash
# _____ * _____Bash DBMS  _____ * _____ #

# _____ * _____AH DATABASE MANAGMENT SYSTEM  _____ * _____ #

# _____ * _____ MAIN SCRIPT  _____ * _____ #
# AHDB stands for => Ayman Hafez Data base
mkdir ./AHDB 2>> ./.error.log
clear
echo "Welcome to AH-DBMS"
createMainMenu
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
  mkdir ./AHDB/$dbName
  if [[ $? == 0 ]]
  then
    echo "$dbName Database Created Successfully";
  else
    echo "Error Creating the database $dbName"; 
  fi
  #echo "==========================================";
  createMainMenu;
}

# function to list the database
function listDB
{
  ls ./AHDB; 
  #echo "==========================================";
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
  #echo "==========================================";
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
function createTableMenu()
{
    echo    "===========================================";
    echo -e "#____*____ * $1 Database Menu * ____*____ #";
    
    echo "1) Create Table";
    echo "2) List Tables";
    echo "3) Drop Table";
    echo "4) Insert Into Table";
    echo "5) Select From Table";
    echo "6) Delete From Table";
    echo "7) Update Table";
    echo "8) clear Screen"; 
    echo "9) Exit";
    echo "===========================================";
    echo -e "Please Enter your choice: \c"
    read ch
    case $ch in
      1)  createTable ;;
      2)  listTables ;;
      3)  dropTable ;;
      4)  insertIntoTable ;;
      5)  selectFromTable ;;
      6)  deleteFromTable ;;
      7)  updateTable ;;
      8)  clearTableScreen ;;
      9)  exit ;;
      *)  echo "Please select a correct number from the given menu";createMainMenu;
    esac
}

# _____ * _____ Table Menu Functions  _____ * _____ #

# a function that create a file for the table
function createTable
{
  #todo
  # notes-from-project-instructions:
    # 1- Ask about columns datatypes in create table and check on them in both insert and update
    # 2- Ask about primary key in create table and check for it in the insert into table

}

# a function that list the tables in the database directory
function listTables
{
  #todo
}

function dropTable
{
  #todo
}

function insertIntoTable
{
  #todo
}

function selectFromTable
{
  # todo
  # note-from-project-instructions:
  # The Select of Rows displayed in screen/terminal in an Accepted/Good Format
}

function deleteFromTable
{
  #todo
}

function updateTable
{
  #todo
}

# A function that clear a table screen
function clearTableScreen
{
  clear;
  createTableMenu;
}
# _____ * _____ End of Table Menu Functions  _____ * _____ #
