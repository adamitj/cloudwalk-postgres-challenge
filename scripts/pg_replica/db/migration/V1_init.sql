/*
Configure the pg_replica instance to act as a subscriber. 
Set up logical replication from pg_master to pg_replica for the orders table. 
*/

-- Needs to create the orders table first   
CREATE TABLE IF NOT EXISTS public.orders (
    id              SERIAL NOT NULL primary key,
    product_name    TEXT NOT NULL,
    quantity        INTEGER NOT NULL,
    order_date      DATE NOT NULL
);

-- Wait for the slot to be available on master
DO $$
BEGIN
    FOR i IN 1..30 LOOP
        BEGIN
            -- drop existing subscription if it exists
            IF EXISTS (SELECT 1 FROM pg_subscription WHERE subname = 'orders_subscription') THEN
                ALTER SUBSCRIPTION orders_subscription DISABLE;
                DROP SUBSCRIPTION orders_subscription;
            END IF;
            -- Try to create the subscription
            CREATE SUBSCRIPTION orders_subscription 
            CONNECTION 'host=pg_master port=5432 user=postgres password=sql dbname=testdb' 
            PUBLICATION orders_publication
            WITH (slot_name=orders_slot, create_slot=false, copy_data=true, enabled=false);
            EXIT;
        EXCEPTION WHEN OTHERS THEN
            PERFORM pg_sleep(2);
            IF i = 30 THEN
                RAISE EXCEPTION 'Failed to create subscription after 30 attempts';
            END IF;
        END;
    END LOOP;
END $$;

-- Enable the subscription
-- for debugging purposes, we can enable subscription after creating it (check the logs)
ALTER SUBSCRIPTION orders_subscription ENABLE;


