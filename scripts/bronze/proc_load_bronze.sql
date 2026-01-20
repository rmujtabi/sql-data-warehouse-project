/*
====================================================================
Stored Procedure: Load Bronze Layer(Source-> Bronze)
====================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following action:
  - Truncate the bronze tables before loading data.
  - Uses the 'BULK Insert' command to load data from CSV files to bronze tables.

Parameters:
  None.
This stored procedure does not accept any parameter or return any values.

Usage Example:
  Exec bronze.load_bronze;
======================================================================  
*/

use DataWarehouse;
go

create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
		set @batch_start_time = getdate();
		print '=============================================';
		print 'Loading Bronze Layer';
		print '=============================================';

		print '---------------------------------------------';
		print 'Loading CRM Table';
		print '---------------------------------------------';
	--SET NOCOUNT ON;
		set @start_time = getdate();
		print'>> Truncating Table : bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;

		print'>> Inserting Data Into : bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\Data Analytics Project\Data Warehouse Project\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' +cast(datediff(second, @start_time, @end_time) as varchar)+ 'seconds';
		print'---------------------';


		set @start_time = getdate();
		print'>> Truncating Table : bronze.crm_prd_info' ;
		truncate table bronze.crm_prd_info;

		print'>> Inserting Data Into : bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'C:\Data Analytics Project\Data Warehouse Project\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		print'>> Load Duration: ' +cast(datediff(second, @start_time, @end_time) as varchar)+ 'seconds';
		print'---------------------';

		set @start_time = getdate();
		print'>> Truncating Table : bronze.crm_sales_details' ;
		truncate table bronze.crm_sales_details;

		print'>> Inserting Data Into : bronze.crm_sales_details' ;
		bulk insert bronze.crm_sales_details
		from 'C:\Data Analytics Project\Data Warehouse Project\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		print'>> Load Duration: ' +cast(datediff(second, @start_time, @end_time) as varchar)+ 'seconds';
		print'---------------------';


		print '---------------------------------------------';
		print 'Loading ERP Table';
		print '---------------------------------------------';
		
		set @start_time = getdate();
		print'>> Truncating Table : bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;

		print'>> Inserting Data Into : bronze.erp_cust_az12' ;
		bulk insert bronze.erp_cust_az12
		from 'C:\Data Analytics Project\Data Warehouse Project\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		print'>> Load Duration: ' +cast(datediff(second, @start_time, @end_time) as varchar)+ 'seconds';
		print'---------------------';

		set @start_time = getdate();
		print'>> Truncating Table : bronze.erp_loc_a101' ;
		truncate table bronze.erp_loc_a101;

		print'>> Inserting Data Into : bronze.erp_loc_a101' ;
		bulk insert bronze.erp_loc_a101
		from 'C:\Data Analytics Project\Data Warehouse Project\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		print'>> Load Duration: ' +cast(datediff(second, @start_time, @end_time) as varchar)+ 'seconds';
		print'---------------------';

		set @start_time = getdate();
		print'>> Truncating Table : bronze.erp_px_cat_g1v2' ;
		truncate table bronze.erp_px_cat_g1v2;

		print'>> Inserting Data Into : bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Data Analytics Project\Data Warehouse Project\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		set @batch_end_time = getdate();
		print'================================================';
		print 'Loading Bronze Layer is completed';
		print'>>Total Load Duration: ' +cast(datediff(second, @start_time, @end_time) as varchar)+ 'seconds';
		print'---------------------';
	end try
	begin catch
		print '==============================================';
		print 'Error occured during loading bronze layer';
		print 'Error Message' + Error_message();
		print 'Error_message' + Cast (Error_number() as varchar);
		print 'Error_message' + Cast (Error_state() as varchar);
		print '==============================================';
	end catch
end;
