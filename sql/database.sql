
DROP TABLE customers_table;
CREATE TABLE customers_table
(
   name           	varchar(30)   NOT NULL,
   surname        	varchar(30)   NOT NULL,
   cell_no		  		varchar(30),
   landline_no		  	varchar(30),
   email		  		   varchar(30),
   comm_channel      varchar(30)   NOT NULL,			
   address		  		json,
   region            varchar(30)   NOT NULL,
   gender            varchar(30),
   reg_date     	   timestamp     NOT NULL,
   created_by_id  	integer		  NOT NULL
);

DROP TABLE product_table;
CREATE TABLE product_table
(
   prod_name           	varchar(30)   NOT NULL,
   prod_type		  		text          NOT NULL,
   quantity		  			integer       NOT NULL,
   target_market        text          NOT NULL,
   price_per_item		  	numeric(15,2) NOT NULL,
   price_per_bulk    	numeric(15,2) NOT NULL			
);

DROP TABLE employee_table;
CREATE TABLE employee_table
(
   name           	varchar(30)   NOT NULL,
   surname        	varchar(30)   NOT NULL,
   cell_no		  		text          NOT NULL,
   email		  			varchar(30),
   address		  		json,
   gender            text,
   employee_id  		integer       NOT NULL,
   reg_date        	timestamp,
   department   		varchar(30),
   employee_rank     varchar(30)   NOT NULL,
   employee_salary   numeric(15,2)  
);

DROP TABLE supplier_table;
CREATE TABLE supplier_table
(
   supplier_name     varchar(30)   NOT NULL,
   address           json,
   contact_no        varchar(30)   NOT NULL,
   email             varchar(30),
   product   	  		json
);

DROP TABLE sales_table;
CREATE TABLE sales_table
(
   customer_id          integer       NOT NULL,
   product  		  		json          NOT NULL,
   seller_id        	   integer       NOT NULL,
   transection_date		timestamp     NOT NULL
);



