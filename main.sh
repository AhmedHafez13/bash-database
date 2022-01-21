#! bin/bash
# _____ * _____ Bash DBMS  _____ * _____ #

# _____ *  AH DATABASE MANAGMENT SYSTEM  * _____ #

# _____ * _____ Globals  _____ * _____ #
cSep=','
typeInt="INT"
typeString="STRING"
cPrimary="PRIMARY KEY"

# _____ * _____ MAIN SCRIPT  _____ * _____ #

# AHDB stands for => Ayman Hafez Data base

# Create the AHDB folder only if it's not exists
if [[ ! -d AHDB ]]
then
  mkdir ./AHDB 
fi
clear
echo "#___ * ___ * Welcome to AH-DBMS * ___ * ___#"

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
      *)  echo "Please select a correct number from the given menu";createTableMenu $1;
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
        string ) dataType="STRING"; break;;
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
    echo "There is no Table with this Name!!";
  fi
  createTableMenu $1;
}

function insertIntoTable
{
  echo -e "Enter the table name: \c";
  read tableName;
  if [[ -f $tableName ]]
  then
    if [[ -f ".$tableName" ]] # Check the metadata file
    then # The metadata file exists
      echo "Inserting into ($tableName)"
      echo "-------------------------------"
      columnsCount=`awk 'END{print NR}' .$tableName`
      recordArr=() # Create an array to store the record
      for n in `seq 2 $columnsCount`
      do
        columnName=`awk 'BEGIN{FS="'$cSep'"} {if(NR=='$n') print $1}' .$tableName`
        columnType=`awk 'BEGIN{FS="'$cSep'"} {if(NR=='$n') print $2}' .$tableName`
        columnKey=`awk 'BEGIN{FS="'$cSep'"} {if(NR=='$n') print $3}' .$tableName`
        let col=$n-1
        echo -e "Insert:$columnKey $columnName as [$columnType]> \c"
        while read input
        do
          if [[ $columnKey == $cPrimary ]]
          then
            # Check if the primary key is in the table
            pkCount=`awk -v col="$col" 'BEGIN{FS=","; NR=2; c=0;} {if ($col == "'$input'") c++;} END{print c;}' $tableName`
            if [[ $pkCount == 1 ]]
            then
              echo "!!! Invalid input, the primary key is in use!"
              echo -e "Insert:$cPrimary $columnName as [$columnType]> \c"
              continue
            fi
          fi

          if [[ $columnType == $typeInt ]] # Invalidate integer
          then
            isNumber $input
            if [[ $? == 1 ]]
            then
              recordArr[$col]=$input # Store the input
              break
            else
              echo "!!! Invalid input, the datatype does not match!"
              echo -e "Insert:$cPrimary $columnName as [$columnType]> \c"
              continue
            fi
          elif [[ $columnType == $typeString ]]
          then
            recordArr[$col]=$input # Store the input
            break
          fi
        done
      done

      record=${recordArr[@]}    # Format the recored
      record=${record// /$cSep} # Format the recored
      echo $record >> $tableName

      echo "### A new record is successfully saved"

      createTableMenu $1

    else # Can't file the metadata file
      echo "!!! The metadata for ($tableName) is corrupted, can not insert into this table"
      createTableMenu $1
    fi
  else
    echo "($tableName) table does not exist, choose a table from the list"
    listTables
    createTableMenu $1
  fi
}

function selectFromTable
{
  # todo
  # note-from-project-instructions:
  # The Select of Rows displayed in screen/terminal in an Accepted/Good Format
  echo -e "Enter the table name: \c";
  read tableName;
  if [[ -f $tableName ]]
  then
    header=`awk '{if(NR==1) print $0}' $tableName`
    colArr=(${header//$cSep/ })

    echo "Choose columns seperated by space to select, or type 0 to select all"
    echo "-------------------------------"
    echo "0) select all columns"
    n=0   # count of columns
    for col in "${colArr[@]}";
    do
      let n++
      echo "$n) $col"
    done

    colNumbers=0
    selectedAll=0

    while read -p "Insert columns> " colInput
    do
      colNumbers=(${colInput// / }) # splite with space
      if [[ ${colNumbers[@]} ]]
      then
        for col in "${colNumbers[@]}";
        do
          isNumber $col # Check if the input is number
          if [[ $? -eq 0 ]] || [[ $col -lt 0 ]] || [[ $col -gt $n ]]
          then
            echo "!!! Enter a valid input"
            continue 2
          else
            if [[ $col -eq 0 ]]
            then
              let selectedAll=1
              break 2
            fi
          fi
        done
      else
        echo "!!! Enter a valid input"
        continue
      fi
      break
    done

    # Ask the user for select conditions
    applyCondition=0

    echo ">> Enter a condition or leave it empty to ommit condition"
    echo ">> Condition must start with column number then operator then param"
    echo "-------------------------------"
    while read -p "Condition> " condition
    do
      condition=${condition//[[:blank:]]/}

      # Get the operator from the condition
      if [[ $condition =~ ">" ]]
      then operator=">"
      elif [[ $condition =~ "<" ]]
      then operator="<"
      elif [[ $condition =~ "=" ]]
      then operator="="
      elif [ -z "$condition" ] # Do not apply condition if empty
      then
        applyCondition=0
        break
      else
        echo "!!! Invalid condition"
        continue
      fi

      isValidCondition $condition $operator $n
      isValid=$?
      if [[ isValid -eq 1 ]]
      then
        applyCondition=1
        break
      else
        echo "!!! Invalid condition"
      fi
    done

    if [[ applyCondition -eq 1 ]]   # Select with condition
    then
      arrIN=(${condition//$operator/ })
      col=${arrIN[0]}
      param=${arrIN[1]}

      if [[ $operator == '=' ]] # invalidate '=' to '=='
      then
        operator='=='
      fi

      echo "==========================================="
      awk 'BEGIN{FS="'$cSep'"} {if($'$col' '$operator' "'$param'" || NR==1) print $0}' $tableName | cut -d ',' -f "$colInput" | column -t -s','
    else    # Select without condition
      echo "==========================================="
      if [[ selectedAll -eq 1 ]]
      then
        column -t -s',' $tableName
      else
        cut -d ',' -f "$colInput" $tableName | column -t -s','
      fi
    fi

    createTableMenu $1    # Back to table options menu
  else
    echo "($tableName) table does not exist, choose a table from the list"
    listTables
    createTableMenu $1
  fi
}

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

# _____ * _____ Helper Functions  _____ * _____ #
isNumber(){
  num=$1
  if [[ "${num##*[!0-9]*}" ]]
  then return 1
  else return 0
  fi
}

isValidCondition(){
  condition=$1
  operator=$2
  colCount=$3

  # Split condition parts
  arrIN=(${condition//$operator/ })
  col=${arrIN[0]}
  param=${arrIN[1]}

  # 1. Check if the col between 1 and colCount
  isNumber $col
  if [[ $? != 1 ]] || [[ col -lt 1 ]] || [[ col -gt colCount ]]
  then return 0
  fi

  # 2. Check if the type is INT the param must be a number
  let col+=1
  columnType=`awk 'BEGIN{FS="'$cSep'"} {if(NR=='$col') print $2}' .$tableName`

  if [[ $columnType == "INT" ]] # Check the param if its type is int
  then
    isNumber $param   # make sure the param is number
    if [[ $? != 1 ]]
    then return 0
    fi
  fi

  return 1  # return 1 as whole the condition is valid
}

# calling the  main menu function that start the script 
createMainMenu;


# @ All rights reserved to Ayman - Hafez - ITI - OS Track - Intake 42;
