-- ============================================================
-- SQL Server: Create Read-Only User for Order Lookup API
-- ============================================================
-- Run this script on your SQL Server database
-- This creates a secure, read-only user for the API

USE master;
GO

-- 1. Create Login (Server level)
CREATE LOGIN order_lookup_api 
WITH PASSWORD = 'AignepUSA37062!@#';
GO

-- 2. Switch to your database (REPLACE 'YourDatabaseName' with actual name)
USE YourDatabaseName;
GO

-- 3. Create User (Database level)
CREATE USER order_lookup_api 
FOR LOGIN order_lookup_api;
GO

-- 4. Grant SELECT permissions ONLY on the 5 required tables
GRANT SELECT ON dbo.vdvsalesorder TO order_lookup_api;
GRANT SELECT ON dbo.vdvsalesorderline TO order_lookup_api;
GRANT SELECT ON dbo.vdvshipment TO order_lookup_api;
GRANT SELECT ON dbo.shipmentline TO order_lookup_api;
GRANT SELECT ON dbo.vdvpackage TO order_lookup_api;
GO

-- 5. Verify permissions (optional - view what the user can access)
SELECT 
    OBJECT_NAME(major_id) AS TableName,
    permission_name AS Permission
FROM sys.database_permissions
WHERE grantee_principal_id = USER_ID('order_lookup_api')
ORDER BY TableName;
GO

-- ============================================================
-- SECURITY NOTES:
-- ============================================================
-- ✅ This user can ONLY read data (SELECT)
-- ✅ Cannot INSERT, UPDATE, DELETE any data
-- ✅ Cannot access other tables
-- ✅ Cannot create/drop objects
-- ✅ Cannot grant permissions to others
--
-- IMPORTANT:
-- 1. Change the password to something strong and unique
-- 2. Store the password in .env file (never in code)
-- 3. Configure SQL Server firewall to allow API server IP only
-- 4. Enable SQL Server and Windows Authentication mode
-- ============================================================

PRINT '✅ Read-only user "order_lookup_api" created successfully!';
PRINT '📋 Next steps:';
PRINT '   1. Update .env file with connection details';
PRINT '   2. Test connection with: npm start';
PRINT '   3. Configure firewall rules';
GO
