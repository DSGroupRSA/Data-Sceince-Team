DROP TABLE clients_table;
CREATE TABLE clients_table
(  id                      SERIAL        PRIMARY KEY,
   name                    varchar(30)   NOT NULL,
   surname                 varchar(30)   NOT NULL,
   cell_no                 varchar(30),
   telephone_no            varchar(30),
   email                   varchar(30),
   comm_channel            varchar(30)   NOT NULL,         
   address                 json,
   region                  varchar(30)   NOT NULL,
   gender                  varchar(30),
   reg_date                timestamp     NOT NULL,
   created_by_id           varchar(30)   NOT NULL
);

