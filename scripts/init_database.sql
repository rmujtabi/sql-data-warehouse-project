/*
=======================================================================
Create Database and Schemas
=======================================================================
Script Purpose:
  This script creates a new database named 'DataWarehouse' after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionally, the script sets up three schema
  within the databse: 'bronze', 'silver', 'gold'.

Warning:
  Running this script will drop the entire 'DataWarehouse' database if exists.
  All data in the database will be permanently deleted. Proceed with caution
  and ensure you have proper backups before running this script.
*/

