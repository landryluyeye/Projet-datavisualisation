show TABLES

SELECT table_schema, table_name FROM information_schema.tables WHERE create_time > NOW() - INTERVAL 1 DAY;