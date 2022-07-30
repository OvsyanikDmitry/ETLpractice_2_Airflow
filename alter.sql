
ALTER TABLE mart.f_sales 
ADD COLUMN status varchar(20);

ALTER TABLE staging.user_order_log  
ADD COLUMN status varchar(20);

ALTER TABLE staging.user_order_log ALTER COLUMN status SET DEFAULT 'shipped';

