/*
Create a small script which will insert some sample rows into the orders table. This will be needed for the next exercises.
*/
INSERT INTO public.orders (
    product_name, 
    quantity, 
    order_date
) 
VALUES
('Product A', 10, '2024-01-01'),
('Product B', 20, '2024-01-02'),
('Product C', 30, '2024-01-03'),
('Product D', 40, '2024-01-04'),
('Product E', 50, '2024-01-05');    
