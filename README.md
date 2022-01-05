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
 ![](https://github.com/amr158/shell_project/blob/master/img/23.png)
 - if you choose 1 it will ask you to enter the database name with some checks on the name it should contain only small or capital letters then it checks if the database already exists

 ![](https://github.com/amr158/shell_project/blob/master/img/26.png)

- if you choose 2 it will list the existing databases

 ![](https://github.com/amr158/shell_project/blob/master/img/30.png)

- if you choose 3 it will ask you for the database name and check for the name then check if the  database exist then connect to this database for more operations

 ![](https://github.com/amr158/shell_project/blob/master/img/34.png)

- if you choose 4 it will ask you for the database name and check for the name if it is right it checks if the database exits then it delete the database

 ![](https://github.com/amr158/shell_project/blob/master/img/38.png)

### A menu is displayed asking for your choice in Table operations when you choose 3 in database menu
 ![](https://github.com/amr158/shell_project/blob/master/img/41.png)
- if you choose 1 it will ask you to enter the Table name with some checks on the name it should contain only small or capital letters then it checks if the Table already exists 

when you enter the table name it will ask you to enter the primary key name and its datatype by default is number , then you must enter at least one column name and datatype 

when you enter column name it checks if the name is right , and checks for the column datatype aslso it should be number or string

 ![](https://github.com/amr158/shell_project/blob/master/img/48.png)
 ![](https://github.com/amr158/shell_project/blob/master/img/49.png)

- if you choose 2 it will list the existing tables

 ![](https://github.com/amr158/shell_project/blob/master/img/53.png)

- if you choose 3 it will ask you for the table name and check for the name then check if the  table exist then connect to this table for more operations

 ![](https://github.com/amr158/shell_project/blob/master/img/57.png)

- if you choose 4 it will ask you for the table name and check for the name if it is right it checks if the table exits then it delete the table
 
 ![](https://github.com/amr158/shell_project/blob/master/img/61.png)

### A menu is displayed asking for your choice in Record operations when you choose 3 in table menu
 ![](https://github.com/amr158/shell_project/blob/master/img/64.png)

- if you choose 1 it will ask you to enter the value of the primary key and checks if the pk value exists then it selects the record and display its fields and values

 ![](https://github.com/amr158/shell_project/blob/master/img/68.png)


- if you choose 2 it will ask you to if you want the pk to be auto incremented , then it displays the name of each column asking you to enter its value and checks if the datatype is valid

 ![](https://github.com/amr158/shell_project/blob/master/img/73.png)
 ![](https://github.com/amr158/shell_project/blob/master/img/74.png)


- if you choose 3 it will ask you for the pk value then asks you to enter the column you want to edit and checks if it is valid then enter the new value

 ![](https://github.com/amr158/shell_project/blob/master/img/79.png)
 ![](https://github.com/amr158/shell_project/blob/master/img/80.png)



- if you choose 4 it will ask you to enter the value of the primary key and checks if the pk value exists then it delete the record from the table 

 ![](https://github.com/amr158/shell_project/blob/master/img/86.png)
 ![](https://github.com/amr158/shell_project/blob/master/img/87.png)




