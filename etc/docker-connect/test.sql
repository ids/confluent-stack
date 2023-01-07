USE KafkaTest;
GO

CREATE TABLE products (
    ProductID int IDENTITY(1,1),  
    Name varchar(50),
    Category varchar(50),
    SKU varchar(50),
    WholesalePrice money,
    RetailPrice money,
    OnHand int,
    ListingDate datetime
);
GO

INSERT INTO products VALUES('Alfalfa Seed', 'Seed', '1010001', 32.34, 45.25, 354, GetDate());
GO

-- before we enable CDC ensure the SQL Server Agent is started
-- we need first to enable CDC on the database
EXEC sys.sp_cdc_enable_db;

-- then we can enable CDC on the table
EXEC sys.sp_cdc_enable_table @source_schema = N'dbo',
                               @source_name   = N'products',
                               @role_name = NULL,
                               @supports_net_changes = 0;