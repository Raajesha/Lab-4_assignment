Create Database if not exists `order-directory` ;
use `order-directory`;
categorycustomerorderproductproduct_detailsratingsupplier
create table if not exists `supplier`(`SUPP_ID` int primary key,`SUPP_NAME` varchar(50) ,
`SUPP_CITY` varchar(50),`SUPP_PHONE` varchar(10));
create table if not exists `customer` (`CUS_ID` INT NOT NULL,`CUS_NAME` VARCHAR(20) NULL DEFAULT NULL, `CUS_PHONE` VARCHAR(10),`CUS_CITY` varchar(30) ,
  `CUS_GENDER` CHAR,PRIMARY KEY (`CUS_ID`));
create table if not exists `category` ( `CAT_ID` INT NOT NULL,`CAT_NAME` VARCHAR(20) NULL DEFAULT NULL,PRIMARY KEY (`CAT_ID`) );
create table if not exists `product` (`PRO_ID` INT NOT NULL,`PRO_NAME` VARCHAR(20) NULL DEFAULT NULL, `PRO_DESC` VARCHAR(60) NULL DEFAULT NULL,`CAT_ID` INT NOT NULL,PRIMARY KEY (`PRO_ID`),
FOREIGN KEY (`CAT_ID`) REFERENCES CATEGORY (`CAT_ID`) );
 create table if not exists `product_details` (`PROD_ID` INT NOT NULL,`PRO_ID` INT NOT NULL, `SUPP_ID` INT NOT NULL, `PROD_PRICE` INT NOT NULL, PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (`PRO_ID`) REFERENCES PRODUCT (`PRO_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER(`SUPP_ID`) );
create table if not exists `order` (`ORD_ID` INT NOT NULL, `ORD_AMOUNT` INT NOT NULL,
  `ORD_DATE` DATE, `CUS_ID` INT NOT NULL,`PROD_ID` INT NOT NULL,
  PRIMARY KEY (`ORD_ID`),  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES PRODUCT_DETAILS(`PROD_ID`) );
create table if not exists `rating` ( `RAT_ID` INT NOT NULL,`CUS_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL, `RAT_RATSTARS` INT NOT NULL,
  PRIMARY KEY (`RAT_ID`), FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER (`SUPP_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`)  );

insert into `supplier` values(1,"Manjunath Distributors","Mangaluru",'9234767810');
insert into `supplier` values(2,"Natraj Retails.","Tumkur",'7589638410');
insert into `supplier` values(3,"Prabhu products","Bengaluru",'9765462123');
insert into `supplier` values(4,"Dhanush Retails","Chennai",'9976663456');
insert into `supplier` values(5,"Mukesh Ltd.","Rajasthan",'8899456785');




  
INSERT INTO `CUSTOMER` VALUES(1,"Abhi",'1111111111',"Mumbai",'M');
INSERT INTO `CUSTOMER` VALUES(2,"Ajith",'2222222222',"Bengaluru",'M');
INSERT INTO `CUSTOMER` VALUES(3,"Nethra",'3333333333',"Mysuru",'F');
INSERT INTO `CUSTOMER` VALUES(4,"Mithra",'4444444444',"Shivamogga",'F');
INSERT INTO `CUSTOMER` VALUES(5,"Puneeth",'8888888888',"Mandya",'M');


 



  
INSERT INTO `CATEGORY` VALUES( 1,"BOOKS");
INSERT INTO `CATEGORY` VALUES(2,"GAMES");
INSERT INTO `CATEGORY` VALUES(3,"GROCERIES");
INSERT INTO `CATEGORY` VALUES (4,"ELECTRONICS");
INSERT INTO `CATEGORY` VALUES(5,"CLOTHES");
  

  
INSERT INTO `PRODUCT` VALUES(1,"GTA V","DFJDJFDJFDJFDJFJF",2);
INSERT INTO `PRODUCT` VALUES(2,"TSHIRT","DFDFJDFJDKFD",5);
INSERT INTO `PRODUCT` VALUES(3,"ROG LAPTOP","DFNTTNTNTERND",4);
INSERT INTO `PRODUCT` VALUES(4,"OATS","REURENTBTOTH",3);
INSERT INTO `PRODUCT` VALUES(5,"HARRY POTTER","NBEMCTHTJTH",1);
  


  
  
INSERT INTO PRODUCT_DETAILS VALUES(1,1,2,1500);
INSERT INTO PRODUCT_DETAILS VALUES(2,3,5,30000);
INSERT INTO PRODUCT_DETAILS VALUES(3,5,1,3000);
INSERT INTO PRODUCT_DETAILS VALUES(4,2,3,2500);
INSERT INTO PRODUCT_DETAILS VALUES(5,4,1,1000);
  

  
INSERT INTO `ORDER` VALUES (50,2000,"2021-10-06",2,1);
INSERT INTO `ORDER` VALUES(20,1500,"2021-10-12",3,5);
INSERT INTO `ORDER` VALUES(25,30500,"2021-09-16",5,2);
INSERT INTO `ORDER` VALUES(26,2000,"2021-10-05",1,1);
INSERT INTO `ORDER` VALUES(30,3500,"2021-08-16",4,3);
  
  

  
INSERT INTO `RATING` VALUES(1,2,2,4);
INSERT INTO `RATING` VALUES(2,3,4,3);
INSERT INTO `RATING` VALUES(3,5,1,5);
INSERT INTO `RATING` VALUES(4,1,3,2);
INSERT INTO `RATING` VALUES(5,4,5,4);
  

select customer.cus_gender,count(customer.cus_gender) as count from customer inner join `order` on customer.cus_id=`order`.cus_id where `order`.ord_amount>=3000 group by customer.cus_gender;
select `order`.*,product.pro_name from `order` ,product_details,product where `order`.cus_id=2 and `order`.prod_id=product_details.prod_id and product_details.prod_id=product.pro_id;
select supplier.* from supplier,product_details where supplier.supp_id in (select product_details.supp_id from product_details group by product_details.supp_id having count(product_details.supp_id)>1) group by supplier.supp_id;
select product.pro_id,product.pro_name from `order` inner join product_details on product_details.prod_id=`order`.prod_id inner join product on product.pro_id=product_details.pro_id where `order`.ord_date>"2021-10-05";

		
select supplier.supp_id,supplier.supp_name,customer.cus_name,rating.rat_ratstars from rating inner join supplier on rating.supp_id=supplier.supp_id inner join customer on rating.cus_id=customer.cus_id order by rating.rat_ratstars desc limit 3;


select customer.cus_name ,customer.cus_gender from customer where customer.cus_name like 'A%' or customer.cus_name like '%A';

select sum(`order`.ord_amount) as Amount from `order` inner join customer on `order`.cus_id=customer.cus_id where customer.cus_gender='M';


select *  from customer left outer join `order` on customer.cus_id=`order`.cus_id; 

DELIMITER &&  
CREATE PROCEDURE proc()
BEGIN
select supplier.supp_id,supplier.supp_name,rating.rat_ratstars,
CASE
    WHEN rating.rat_ratstars >4 THEN 'Genuine Supplier'
    WHEN rating.rat_ratstars>2 THEN 'Average Supplier'
    ELSE 'Supplier should not be considered'
END AS verdict from rating inner join supplier on supplier.supp_id=rating.supp_id;
END &&  
DELIMITER ;  

call proc();

