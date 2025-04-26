
/*
Create a PostgreSQL database called testDB inside the pg_master. Inside testDB, create a table called orders with the following columns:

id: Integer, primary key, auto-increment
product_name: Text
quantity: Integer
order_date: Date
*/
-- Create the orders table
CREATE TABLE IF NOT EXISTS public.orders (
    id              SERIAL NOT NULL primary key,
    product_name    TEXT NOT NULL,
    quantity        INTEGER NOT NULL,
    order_date      DATE NOT NULL
);

-- Drop existing publication if it exists
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_publication WHERE pubname = 'orders_publication') THEN
        DROP PUBLICATION orders_publication;
    END IF;
END $$;

-- Drop existing slot if it exists
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_replication_slots WHERE slot_name = 'orders_slot') THEN
        PERFORM pg_drop_replication_slot('orders_slot');
    END IF;
END $$;

/*
Configure the pg_master instance to act as a publisher. 
Validate that changes on pg_master are reflected on pg_replica by using the script from 1.
*/

-- Create a named replication slot on pg_master
SELECT pg_create_logical_replication_slot('orders_slot', 'pgoutput');

-- Create a publication on pg_master
CREATE PUBLICATION orders_publication FOR TABLE public.orders;




    
