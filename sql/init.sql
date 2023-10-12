CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    price INT,
    currency STRING,
    number_of_items int,
    country STRING
) WITH (ttl_expire_after = '5 minutes', ttl_job_cron = '*/1 * * * *');

SET cluster setting kv.rangefeed.enabled = true;