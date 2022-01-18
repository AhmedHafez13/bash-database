#! bin/bash
# _____ * _____Bash DBMS  _____ * _____ #

# _____ * _____AH DATABASE MANAGMENT SYSTEM  _____ * _____ #

# _____ * _____ MAIN SCRIPT  _____ * _____ #
mkdir AHDB 2 >> ./AHDB/error.log
clear
echo "Welcome to AH-DBMS"
createMainMenu
# _____ * _____ END OF MAIN SCRIPT  _____ * _____ #











# Create main Menu Function
function createMainMenu 
{
    echo -e "#_____ * _____ * Main Menu _____ * _____ #";
    
    echo "1) Create Database";

    echo "2) List Databases";

    echo "3) Connect To Databases";

    echo "4) Drop Database";

    echo "5) Exit";

    echo "===========================================";

    echo -e "Please Enter your choice: \c"
    read ch
    case $ch in
      1)  createDB ;;
      2)  listDB ;;
      3)  connectToDB ;;
      4)  dropDB ;;
      5)  exit ;;
      *)  echo "Please select a correct number from the given menu;" createMainMenu;
    esac
}


# a function that create a database as a folder relative to the script
# function createDB 
# {
#   echo -e "Please Enter the database name: \c";
#   read dbName;
#   mkdir ./

# }