# Notes, TODOs and Bugs

## Ayman Part

### On creating new database
- Check if the input for the name is valid before creating the directory
    - When creating a database with an empty name the app shows this error
      > mkdir: cannot create directory ‘./AHDB/’: File exists
      >
      > Error Creating the database

- Sometimes this error is shown when creating new database
  => Error: mkdir: cannot create directory ‘./AHDB’: File exists

### On creating new table
- Check if the input for the name is valid before asking for columns count

### In the `Database Menu`
- When the user hits enter without input the `Main Menu` is displayed insted on database menu

### Listing databases and tables
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


