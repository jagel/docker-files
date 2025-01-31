# How to create a use in MSSQL?

Create user ``your_user`` for the database ``your_database`` and it gives access to read, write and create alter and drop objects inthe database

```sql
USE [master];
GO

CREATE LOGIN [your_user] WITH PASSWORD = 'your_strong_password';
GO

USE [your_database];
GO

-- Create a user for the login in the database
CREATE USER your_user FOR LOGIN [your_user]


-- Can read all data from all user tables and views in the database.
EXEC sp_addrolemember 'db_datareader', [your_user];

-- Can add, modify, and delete data in all user tables and views in the database.
EXEC sp_addrolemember 'db_datawriter', [your_user];

-- Can execute CREATE, ALTER, and DROP statements for objects in the database (e.g., tables, views, stored procedures). // Does not grant permission to view or modify data.
EXEC sp_addrolemember 'db_ddladmin', [your_user];
```


## Roles list 

``db_owner``:

    Full control over the database. Members can perform any activity, including managing permissions and modifying the database schema.
    Equivalent to "admin" for a specific database.

``db_securityadmin``

    Can manage database-level security roles and permissions.
    Be careful when granting this, as members can elevate their permissions.

``db_accessadmin``

    Can add or remove access for database users.

``db_backupoperator``

    Can perform backups for the database but cannot manage security or make schema changes.

``db_ddladmin``

    Can execute CREATE, ALTER, and DROP statements for objects in the database (e.g., tables, views, stored procedures).
    Does not grant permission to view or modify data.

``db_datareader``

    Can read all data from all user tables and views in the database.

``db_datawriter``

    Can add, modify, and delete data in all user tables and views in the database.

``db_denydatareader``

    Denies read access to all user tables and views in the database, overriding other granted read permissions.

``db_denydatawriter``

    Denies write access to all user tables and views in the database, overriding other granted write permissions.