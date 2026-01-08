-- SHOW BACKUP FROM LATEST IN 'nodelocal://1/my-cluster-backup';
-- SELECT
--     database_name,
--     parent_schema_name,
--     object_name,
--     object_type
-- FROM
--     [SHOW BACKUP LATEST IN 'nodelocal://1/my-cluster-backup']
-- WHERE
--     object_type = 'table'
--     AND object_name = 'orders';

RESTORE TABLE defaultdb.public.orders FROM LATEST IN 'nodelocal://1/my-cluster-backup' WITH DETACHED;
