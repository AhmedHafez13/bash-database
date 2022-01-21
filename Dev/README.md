# Notes, TODOs and Bugs

## Ayman's Part

### On creating new database `[solved]`
- Check if the input for the name is valid before creating the directory
    - When creating a database with an empty name the app shows this error
      > mkdir: cannot create directory ‘./AHDB/’: File exists
      >
      > Error Creating the database

- Sometimes this error is shown when creating new database
  => Error: mkdir: cannot create directory ‘./AHDB’: File exists

-  `note`: The `AHDB` directory is creating on the execution of the script this issue was because their was no  check of the existence of the AHDB directory
    - `problem solved` by adding a condition  that checks for the existence of the AHDB directory. 
### On creating new table
- Check if the input for the name is valid before asking for columns count

### `[CRITICAL]` In the `Database Menu` `[Problem solved]`
- When the user hits enter without input the `Main Menu` is displayed insted on database menu

### Listing databases and tables `[solved]`
#### ✔ ` Feature  added` 
- Add any prompt before the names of databases and tables
    > for exampe the databases list should be like this
    >
    > \>> ITI_db
    >
    > \>> hello_words_db
    >
    > \>> database_3
    >
    > \>> the_forth_db


# Hafez's Part

## TODO List
- ✔ `[DONE]` `insertIntoTable` function
- ✔ `[DONE]` `selectFromTable` function
    - ✔ `[DONE]` Selete all from table
    - ✔ `[DONE]` Select specific columns from table
    - ✔ `[DONE]` Select under condition from table
- 📌 `[]` updateTable
- `[]` deleteFromTable

### On inserting new record in a table
- Check if the string is empty

### `[Critical]` commiting day to day work

- After finishing any feature merge and commit it to the main branch
- `note` rebase the branch before merging it.
