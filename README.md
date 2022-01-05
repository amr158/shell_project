# DBMS Bash Script Project
A simple DBMS project using Bash Script 
Implemented by #Amr_Ahmed and #Elari_Adham - ITI intake 42-cloud track

# Features Supported by the project
- Create/Drop Database
- List Available Database
- Connect to Existing database
- Create/Drop Table
- List Available Table
- Connect to Existing Table
- Insert a record in table
- Delete a record from table
- Update a record in table
- select a record in table

# How it works
### Download and go to shell_project directory and run the following script
```
./DBMS.sh
```
### A menu is displayed asking for your choice in Database operations
 ![]()
 - if you choose 1 it will ask you to enter the database name with some checks on the name it should contain only small or capital letters then it checks if the database already exists

 ![]()

- if you choose 2 it will list the existing databases

 ![]()

- if you choose 3 it will ask you for the database name and check for the name then check if the  database exist then connect to this database for more operations

 ![]()

- if you choose 4 it will ask you for the database name and check for the name if it is right it checks if the database exits then it delete the database

 ![]()

### A menu is displayed asking for your choice in Table operations when you choose 3 in database menu
 ![]()
- if you choose 1 it will ask you to enter the Table name with some checks on the name it should contain only small or capital letters then it checks if the Table already exists 

when you enter the table name it will ask you to enter the primary key name and its datatype by default is number , then you must enter at least one column name and datatype 

when you enter column name it checks if the name is right , and checks for the column datatype aslso it should be number or string

 ![]()
 ![]()

- if you choose 2 it will list the existing tables

 ![]()

- if you choose 3 it will ask you for the table name and check for the name then check if the  table exist then connect to this table for more operations

 ![]()

- if you choose 4 it will ask you for the table name and check for the name if it is right it checks if the table exits then it delete the table
 
 ![]()

### A menu is displayed asking for your choice in Record operations when you choose 3 in table menu
 ![]()

- if you choose 1 it will ask you to enter the value of the primary key and checks if the pk value exists then it selects the record and display its fields and values

 ![]()


- if you choose 2 it will ask you to if you want the pk to be auto incremented , then it displays the name of each column asking you to enter its value and checks if the datatype is valid

 ![]()
 ![]()


- if you choose 3 it will ask you for the pk value then asks you to enter the column you want to edit and checks if it is valid then enter the new value

 ![]()



- if you choose 4 it will ask you to enter the value of the primary key and checks if the pk value exists then it delete the record from the table 

 ![]()




