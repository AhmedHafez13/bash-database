#! bin/bash
# _____ * _____Bash DBMS  _____ * _____ #

# _____ * _____AH DATABASE MANAGMENT SYSTEM  _____ * _____ #

# _____ * _____ MAIN SCRIPT  _____ * _____ #
#Ayman Hafez Data base
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
# function connectToDB
# {
#   # todo
# }

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