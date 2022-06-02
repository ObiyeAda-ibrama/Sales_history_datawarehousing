#I_with sh2
set echo on

set timing on

set linesize 1000

SELECT p.prod_id, p.prod_category, t.calendar_month_desc, s.quantity_sold, TO_CHAR(SUM(amount_sold), '9,999,999,999') TOTAL_SALES$
FROM sh2.products p, sh2.sales s, sh2.times t
WHERE p.prod_id= s.prod_id
  AND s.time_id= t.time_id
  AND s.quantity_sold > 30 AND s.quantity_sold < 40 
GROUP BY p.prod_id, p.prod_category, t.calendar_month_desc, s.quantity_sold;

#sh2 XP
set echo on

EXPLAIN PLAN FOR
SELECT p.prod_id, p.prod_category, t.calendar_month_desc, s.quantity_sold, TO_CHAR(SUM(amount_sold), '9,999,999,999') TOTAL_SALES$
FROM sh2.products p, sh2.sales s, sh2.times t
WHERE p.prod_id= s.prod_id
  AND s.time_id= t.time_id
  AND s.quantity_sold > 30 AND s.quantity_sold < 40 
GROUP BY p.prod_id, p.prod_category, t.calendar_month_desc, s.quantity_sold;



#with DWU
set echo on

set timing on

set linesize 1000

SELECT p.prod_id, p.prod_category, t.calendar_month_desc, s.quantity_sold, TO_CHAR(SUM(amount_sold), '9,999,999,999') TOTAL_SALES$
FROM DWU99.products p, DWU99.sales s, DWU99.times t
WHERE p.prod_id= s.prod_id
  AND s.time_id= t.time_id
  AND s.quantity_sold > 30 AND s.quantity_sold < 40 
GROUP BY p.prod_id, p.prod_category, t.calendar_month_desc, s.quantity_sold;

#DWU XP
set echo on

EXPLAIN PLAN FOR
SELECT p.prod_id, p.prod_category, t.calendar_month_desc, s.quantity_sold, TO_CHAR(SUM(amount_sold), '9,999,999,999') TOTAL_SALES$
FROM DWU3.products p, DWU3.sales s, DWU3.times t
WHERE p.prod_id= s.prod_id
  AND s.time_id= t.time_id
  AND s.quantity_sold > 30 AND s.quantity_sold < 40 
GROUP BY p.prod_id, p.prod_category, t.calendar_month_desc, s.quantity_sold;
 
 set linesize 200
set pagesize 50
set markup html preformat on
select * from table(dbms_xplan.display());

#########################################################################################################

#II with sh2
set echo on

set timing on

set linesize 1000

SELECT c.cust_id, c.cust_year_of_birth, ch.channel_desc, TO_CHAR(SUM(amount_sold), '9,999,999,999') TOTAL_SALES$
FROM sh2.customers c, sh2.channels ch, sh2.sales s 
WHERE ch.channel_id = s.channel_id
  AND c.cust_id = s.cust_id
  AND c.cust_year_of_birth > 1940 AND c.cust_year_of_birth < 1988
GROUP BY c.cust_id, c.cust_year_of_birth, ch.channel_desc;


#sh2 XP
set echo on

EXPLAIN PLAN FOR
SELECT c.cust_id, c.cust_year_of_birth, ch.channel_desc, TO_CHAR(SUM(amount_sold), '9,999,999,999') TOTAL_SALES$
FROM sh2.customers c, sh2.channels ch, sh2.sales s 
WHERE ch.channel_id = s.channel_id
  AND c.cust_id = s.cust_id
  AND c.cust_year_of_birth > 1940 AND c.cust_year_of_birth < 1988
GROUP BY c.cust_id, c.cust_year_of_birth, ch.channel_desc;



#with DWU
set echo on

set timing on

set linesize 1000

SELECT c.cust_id, c.cust_year_of_birth, ch.channel_desc, TO_CHAR(SUM(amount_sold), '9,999,999,999') TOTAL_SALES$
FROM DWU99.customers c, DWU99.channels ch, DWU99.sales s 
WHERE ch.channel_id = s.channel_id
  AND c.cust_id = s.cust_id
  AND c.cust_year_of_birth > 1940 AND c.cust_year_of_birth < 1988
GROUP BY c.cust_id, c.cust_year_of_birth, ch.channel_desc;


#DWU XP
set echo on

EXPLAIN PLAN FOR
SELECT c.cust_id, c.cust_year_of_birth, ch.channel_desc, TO_CHAR(SUM(amount_sold), '9,999,999,999') TOTAL_SALES$
FROM DWU99.customers c, DWU99.channels ch, DWU99.sales s 
WHERE ch.channel_id = s.channel_id
  AND c.cust_id = s.cust_id
  AND c.cust_year_of_birth > 1940 AND c.cust_year_of_birth < 1988
GROUP BY c.cust_id, c.cust_year_of_birth, ch.channel_desc;

#########################################################################################################
#########################################################################################################


CREATE BITMAP INDEX promotions_prom_cat_bix
	ON promotions(promo_category)
        NOLOGGING COMPUTE STATISTICS
        ;
#promotions_prom_cat_bix
#QUERY_DWU
set echo on

set timing on

set linesize 1000

SELECT pr.promo_id, pr.promo_category, c.cust_city, co.country_name, TO_CHAR(SUM(quantity_sold), '9,999,999,999') TOTAL_Sold
FROM DWU99.promotions pr, DWU99.customers c, DWU99.sales s, DWU99.countries co  
WHERE pr.promo_id = s.promo_id
  AND c.cust_id = s.cust_id
  AND c.cust_city != 'Accomac'
GROUP BY pr.promo_id, pr.promo_category, c.cust_city, co.country_name;


#DWU XP
set echo on

EXPLAIN PLAN FOR
SELECT pr.promo_id, pr.promo_category, c.cust_city, co.country_name, TO_CHAR(SUM(quantity_sold), '9,999,999,999') TOTAL_Sold
FROM DWU99.promotions pr, DWU99.customers c, DWU99.sales s, DWU99.countries co  
WHERE pr.promo_id = s.promo_id
  AND c.cust_id = s.cust_id
  AND c.cust_city != 'Accomac'
GROUP BY pr.promo_id, pr.promo_category, c.cust_city, co.country_name;


#QUERY_sh2
set echo on

set timing on

set linesize 1000

SELECT pr.promo_id, pr.promo_category, c.cust_city, co.country_name, TO_CHAR(SUM(quantity_sold), '9,999,999,999') TOTAL_Sold
FROM sh2.customers c, sh2.promotions pr, sh2.sales s, sh2.countries co  
WHERE pr.promo_id = s.promo_id
  AND c.cust_id = s.cust_id
  AND c.cust_city != 'Accomac'
GROUP BY pr.promo_id, pr.promo_category, c.cust_city, co.country_name;


#sh2 XP
set echo on

EXPLAIN PLAN FOR
SELECT pr.promo_id, pr.promo_category, c.cust_city, co.country_name, TO_CHAR(SUM(quantity_sold), '9,999,999,999') TOTAL_Sold
FROM sh2.customers c, sh2.promotions pr, sh2.sales s, sh2.countries co  
WHERE pr.promo_id = s.promo_id
  AND c.cust_id = s.cust_id
  AND c.cust_city != 'Accomac'
GROUP BY pr.promo_id, pr.promo_category, c.cust_city, co.country_name;

#########################################

CREATE BITMAP INDEX times_cal_year_bix
	ON times(calendar_year)
        NOLOGGING COMPUTE STATISTICS ;
        
#times_cal_year_bix
#DWU QUERY
set echo on

set timing on

set linesize 1000
explain plan for
SELECT pr.promo_id, p.prod_name, t.calendar_year, TO_CHAR(SUM(quantity_sold), '9,999,999,999') TOTAL_Sold
FROM DWU69.promotions pr, DWU69.products p, DWU69.times t, DWU69.sales s
WHERE pr.promo_id = s.promo_id
  AND p.prod_id= s.prod_id
  AND t.time_id= s.time_id
  AND pr.promo_category in ('TV', 'magazine', 'internet')
GROUP BY pr.promo_id, p.prod_name, t.calendar_year;


#DWUXP
set echo on

EXPLAIN PLAN FOR
SELECT pr.promo_id, pr.promo_category, p.prod_name, t.calendar_year, TO_CHAR(SUM(quantity_sold), '9,999,999,999') TOTAL_Sold
FROM DWU99.promotions pr, DWU99.products p, DWU99.times t, DWU99.sales s
WHERE pr.promo_id = s.promo_id
  AND p.prod_id= s.prod_id
  AND t.time_id= s.time_id
  AND pr.promo_category in ('TV', 'magazine', 'internet')
GROUP BY pr.promo_id, pr.promo_category, p.prod_name, t.calendar_year;


#SH2 QUERY
set echo on

set timing on

set linesize 1000

SELECT pr.promo_id, p.prod_name, t.calendar_year, TO_CHAR(SUM(quantity_sold), '9,999,999,999') TOTAL_Sold
FROM sh2.promotions pr, sh2.products p, sh2.times t, sh2.sales s
WHERE pr.promo_id = s.promo_id
  AND p.prod_id= s.prod_id
  AND t.time_id= s.time_id
  AND pr.promo_category in ('TV', 'magazine', 'internet')
GROUP BY pr.promo_id, p.prod_name, t.calendar_year;

#sh2XP
set echo on

EXPLAIN PLAN FOR
SELECT pr.promo_id, p.prod_name, t.calendar_year, TO_CHAR(SUM(quantity_sold), '9,999,999,999') TOTAL_Sold
FROM sh2.promotions pr, sh2.products p, sh2.times t, sh2.sales s
WHERE pr.promo_id = s.promo_id
  AND p.prod_id= s.prod_id
  AND t.time_id= s.time_id
  AND pr.promo_category in ('TV', 'magazine', 'internet')
GROUP BY pr.promo_id, pr.promo_category, p.prod_name, t.calendar_year;



#########################################################################################################
#########################################################################################################


#MATERIALIZED_VIEW
#cal_month_sales_mv SH2 WITH MV
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = TRUE;

set timing on
Set pagesize 50

SELECT t.calendar_month_desc, sum(s.amount_sold)
FROM SH2.times t JOIN SH2.sales s ON t.time_id = s.time_id
WHERE t.calendar_month_desc IN ('2003-05', '2004-11')
GROUP BY t.calendar_month_desc;

#XPcal_month_sales_mv SH2 WITH MV
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = TRUE;

set timing on

EXPLAIN PLAN FOR
SELECT t.calendar_month_desc, sum(s.amount_sold)
FROM SH2.times t JOIN SH2.sales s ON t.time_id = s.time_id
WHERE t.calendar_month_desc IN ('2003-05', '2004-11')
GROUP BY t.calendar_month_desc;


REM Now Let us Display the Output of the Explain Plan

set linesize 200
set pagesize 50
set markup html preformat on
select * from table(dbms_xplan.display());



#cal_month_sales_mv DWU WITHout MV
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = FALSE;

set timing on

SELECT t.calendar_month_desc, sum(s.amount_sold)
FROM DWU3.times t JOIN DWU3.sales s ON t.time_id = s.time_id
WHERE t.calendar_month_desc IN ('2003-05', '2004-11')
GROUP BY t.calendar_month_desc;

#XPcal_month_sales_mv DWU WITHOUT MV
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = FALSE;

set timing on

EXPLAIN PLAN FOR
SELECT t.calendar_month_desc, sum(s.amount_sold)
FROM DWU3.times t JOIN DWU3.sales s ON t.time_id = s.time_id
WHERE t.calendar_month_desc IN ('2003-05', '2004-11')
GROUP BY t.calendar_month_desc;
REM Now Let us Display the Output of the Explain Plan

set linesize 200
set pagesize 50
set markup html preformat on
select * from table(dbms_xplan.display());

#########################################

#fweek_pscat_sales_mv SH2 WITH MV
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = TRUE;

set timing on
Set pagesize 50

SELECT t.week_ending_day, p.prod_subcategory, s.channel_id, pr.promo_id, sum(s.amount_sold)  AS TOTAL_SALES
FROM SH2.times t JOIN SH2.sales s ON t.time_id = s.time_id
JOIN SH2.products p ON p.prod_id = s.prod_id
JOIN SH2.promotions pr ON pr.promo_id = s.promo_id
WHERE p.prod_subcategory IN ('Jeans - Men', 'Dresses - Women', 'Outerwear - Men', 'Dresses - Girls')
GROUP BY t.week_ending_day, p.prod_subcategory, s.channel_id, pr.promo_id;


#XPfweek_pscat_sales_mv SH2 WITH MV
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = TRUE;

set timing on

EXPLAIN PLAN FOR
SELECT t.week_ending_day, p.prod_subcategory, s.channel_id, pr.promo_id, sum(s.amount_sold)  AS TOTAL_SALES
FROM SH2.times t JOIN SH2.sales s ON t.time_id = s.time_id
JOIN SH2.products p ON p.prod_id = s.prod_id
JOIN SH2.promotions pr ON pr.promo_id = s.promo_id
WHERE p.prod_subcategory IN ('Jeans - Men', 'Dresses - Women', 'Outerwear - Men', 'Dresses - Girls')
GROUP BY t.week_ending_day, p.prod_subcategory, s.channel_id, pr.promo_id;

REM Now Let us Display the Output of the Explain Plan

set linesize 200
set pagesize 50
set markup html preformat on
select * from table(dbms_xplan.display());



#fweek_pscat_sales_mv DWU WITHout MV
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = FALSE;

set timing on
set pagesize 50

SELECT t.week_ending_day, p.prod_subcategory, s.channel_id, pr.promo_id, sum(s.amount_sold)  AS TOTAL_SALES
FROM DWU3.times t JOIN DWU3.sales s ON t.time_id = s.time_id
JOIN DWU3.products p ON p.prod_id = s.prod_id
JOIN DWU3.promotions pr ON pr.promo_id = s.promo_id
WHERE p.prod_subcategory IN ('Jeans - Men', 'Dresses - Women', 'Outerwear - Men', 'Dresses - Girls')
GROUP BY t.week_ending_day, p.prod_subcategory, s.channel_id, pr.promo_id;

#XPfweek_pscat_sales_mv DWU WITHOUT MV
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = FALSE;

set timing on

EXPLAIN PLAN FOR
SELECT t.week_ending_day, p.prod_subcategory, s.channel_id, pr.promo_id, sum(s.amount_sold)  AS TOTAL_SALES
FROM DWU3.times t JOIN DWU3.sales s ON t.time_id = s.time_id
JOIN DWU3.products p ON p.prod_id = s.prod_id
JOIN DWU3.promotions pr ON pr.promo_id = s.promo_id
WHERE p.prod_subcategory IN ('Jeans - Men', 'Dresses - Women', 'Outerwear - Men', 'Dresses - Girls')
GROUP BY t.week_ending_day, p.prod_subcategory, s.channel_id, pr.promo_id;

REM Now Let us Display the Output of the Explain Plan

set linesize 200
set pagesize 50
set markup html preformat on
select * from table(dbms_xplan.display());




#########################################################################################################
#########################################################################################################



#AGE_CHAN_WEEKLY_sales_mv
CREATE MATERIALIZED VIEW AGE_CHAN_WEEKLY_sales_mv
PCTFREE 5
BUILD IMMEDIATE
REFRESH FORCE
ENABLE QUERY REWRITE
AS
SELECT   c.cust_year_of_birth, p.prod_category, ch.channel_desc, t.week_ending_day, sum(s.quantity_sold) AS Total_quantity, sum(s.amount_sold) AS SALES
FROM  customers c, products p, channels ch, sales s, times t
WHERE    c.cust_id = s.cust_id
AND      p.prod_id = s.prod_id
AND      ch.channel_id = s.channel_id
AND      t.time_id = s.time_id
GROUP BY c.cust_year_of_birth, p.prod_category, ch.channel_desc, t.week_ending_day;



#COUNTRY_PROD_MONTHLY_sales_mv
CREATE MATERIALIZED VIEW COUNTRY_PROD_MONTHLY_sales_mv
PCTFREE 5
BUILD IMMEDIATE
REFRESH FORCE
ENABLE QUERY REWRITE
AS
SELECT   c.country_id, p.prod_subcategory, t.calendar_month_desc, sum(s.amount_sold) AS MONTHLY_SALES
FROM  customers c, products p, sales s, times t
WHERE    c.cust_id = s.cust_id
AND      p.prod_id = s.prod_id
AND      t.time_id = s.time_id
GROUP BY c.country_id, p.prod_subcategory, t.calendar_month_desc;



#PROD_STATUS_mv
CREATE MATERIALIZED VIEW PROD_STATUS_mv
PCTFREE 5
BUILD IMMEDIATE
REFRESH FORCE
ENABLE QUERY REWRITE
AS
SELECT   p.prod_id, p.prod_name, p.prod_status, cos.unit_price AS PRICE$
FROM   products p, costs cos
WHERE  p.prod_id = cos.prod_id
GROUP BY p.prod_id, p.prod_name, p.prod_status, cos.unit_price;

#########################################

#QUERIES

##AGE_CHAN_WEEKLY_sales_mv DWU QUERY
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = TRUE;

set timing on

EXPLAIN PLAN FOR
SELECT   c.cust_year_of_birth, p.prod_category, ch.channel_desc, t.week_ending_day, sum(s.quantity_sold) AS Total_quantity, sum(s.amount_sold) AS SALES
FROM  DWU3.customers c JOIN DWU3.sales s ON c.cust_id = s.cust_id
JOIN DWU3.products p ON p.prod_id = s.prod_id
JOIN DWU3.channels ch ON ch.channel_id = s.channel_id
JOIN DWU3.times t ON t.time_id = s.time_id
WHERE c.cust_year_of_birth > 1980
GROUP BY c.cust_year_of_birth, p.prod_category, ch.channel_desc, t.week_ending_day;

set linesize 200
set pagesize 50
set markup html preformat on
select * from table(dbms_xplan.display());

##SH2 QUERY without AGE_CHAN_WEEKLY_sales_mv 
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = FALSE;

set timing on

EXPLAIN PLAN FOR
SELECT   c.cust_year_of_birth, p.prod_category, ch.channel_desc, t.week_ending_day, sum(s.quantity_sold) AS Total_quantity, sum(s.amount_sold) AS SALES
FROM  SH2.customers c JOIN SH2.sales s ON c.cust_id = s.cust_id
JOIN SH2.products p ON p.prod_id = s.prod_id
JOIN SH2.channels ch ON ch.channel_id = s.channel_id
JOIN SH2.times t ON t.time_id = s.time_id
WHERE c.cust_year_of_birth > 1980
GROUP BY c.cust_year_of_birth, p.prod_category, ch.channel_desc, t.week_ending_day;

set linesize 200
set pagesize 50
set markup html preformat on
select * from table(dbms_xplan.display());




##COUNTRY_PROD_MONTHLY_sales_mv DWU QUERY
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = TRUE;

set timing on

EXPLAIN PLAN FOR
SELECT   c.country_id, p.prod_subcategory, t.calendar_month_desc
FROM  DWU3.customers c JOIN DWU3.SALES S ON c.cust_id = s.cust_id
JOIN DWU3.products p ON p.prod_id = s.prod_id
JOIN DWU3.times t ON t.time_id = s.time_id
WHERE c.country_id IN ('NL', 'AR', 'ZA')
AND p.prod_subcategory IN ('Shirts And Jackets - Women', 'Outerwear - Men', 'Underwear - Girls')
GROUP BY c.country_id, p.prod_subcategory, t.calendar_month_desc;

set linesize 200
set pagesize 50
set markup html preformat on
select * from table(dbms_xplan.display());

##SH2 QUERY without COUNTRY_PROD_MONTHLY_sales_mv 
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = FALSE;

set timing on

EXPLAIN PLAN FOR
SELECT   c.country_id, p.prod_subcategory, t.calendar_month_desc
FROM SH2.customers c JOIN SH2.SALES S ON c.cust_id = s.cust_id
JOIN SH2.products p ON p.prod_id = s.prod_id
JOIN SH2.times t ON t.time_id = s.time_id
WHERE c.country_id IN ('NL', 'AR', 'ZA')
AND p.prod_subcategory IN ('Shirts And Jackets - Women', 'Outerwear - Men', 'Underwear - Girls')
GROUP BY c.country_id, p.prod_subcategory, t.calendar_month_desc;

set linesize 200
set pagesize 50
set markup html preformat on
select * from table(dbms_xplan.display());




##PROD_STATUS_mv DWU QUERY
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = TRUE;

set timing on

EXPLAIN PLAN FOR
SELECT   p.prod_id, p.prod_name, p.prod_status, cos.unit_price AS PRICE$
FROM   DWU3.products p JOIN DWU3.costs cos ON p.prod_id = cos.prod_id
WHERE  cos.unit_price  > 100 AND cos.unit_price < 1000
GROUP BY p.prod_id, p.prod_name, p.prod_status, cos.unit_price;


set linesize 200
set pagesize 50
set markup html preformat on
select * from table(dbms_xplan.display());

##SH2 QUERY without PROD_STATUS_mv
alter session set query_rewrite_integrity = TRUSTED;
alter session set query_rewrite_enabled = FALSE;

set timing on

EXPLAIN PLAN FOR
SELECT   p.prod_id, p.prod_name, p.prod_status, cos.unit_price AS PRICE$
FROM   SH2.products p JOIN SH2.costs cos ON p.prod_id = cos.prod_id
WHERE  cos.unit_price  > 100 AND cos.unit_price < 1000
GROUP BY p.prod_id, p.prod_name, p.prod_status, cos.unit_price;


set linesize 200
set pagesize 50
set markup html preformat on
select * from table(dbms_xplan.display());




#########################################################################################################
#########################################################################################################


#CUBE


EXPLAIN PLAN FOR
SELECT p.prod_category "Product Category", t.calendar_month_desc "Calender Month", c.cust_gender "Gender",
TO_CHAR(SUM(s.amount_sold), '9,999,999,999') "Sales"
 FROM sh2.sales s, sh2.customers c, sh2.times t, sh2.products p
 WHERE s.time_id = t.time_id 
 AND s.cust_id = c.cust_id 
 AND s.prod_id = p.prod_id 
 AND p.prod_category IN ('Girls', 'Boys') 
 AND t.calendar_month_desc IN ('2002-01', '2002-02')
 GROUP BY CUBE (p.prod_category, t.calendar_month_desc, c.cust_gender)
  Order By 1;
  
 


#########################################

SET PAGESIZE 30
COLUMN COUNTRY FORMAT A25 
EXPLAIN PLAN FOR 
SELECT P.PROD_CATEGORY AS PRODUCT_CATEGORY, T.CALENDAR_MONTH_DESC AS CALENDER_MONTH, C.CUST_GENDER AS GENDER, TO_CHAR(SUM(S.AMOUNT_SOLD), '9,999,999,999') AS SALES
FROM SALES S INNER JOIN TIMES T ON S.TIME_ID = T.TIME_ID
INNER JOIN CUSTOMERS C ON S.CUST_ID = C. CUST_ID
INNER JOIN PRODUCTS P ON S.PROD_ID = P.PROD_ID
WHERE P.PROD_CATEGORY IN ('Girls', 'Boys')  
AND T.CALENDAR_MONTH_DESC IN ('2002-01', '2002-02')
GROUP BY P.PROD_CATEGORY, T.CALENDAR_MONTH_DESC, C.CUST_GENDER
UNION ALL
SELECT P.PROD_CATEGORY AS PRODUCT_CATEGORY, T.CALENDAR_MONTH_DESC AS CALENDER_MONTH, NULL, TO_CHAR(SUM(S.AMOUNT_SOLD), '9,999,999,999') AS SALES
FROM SALES S INNER JOIN TIMES T ON S.TIME_ID = T.TIME_ID
INNER JOIN CUSTOMERS C ON S.CUST_ID = C. CUST_ID
INNER JOIN PRODUCTS P ON S.PROD_ID = P.PROD_ID
WHERE P.PROD_CATEGORY IN ('Girls', 'Boys')  
AND T.CALENDAR_MONTH_DESC IN ('2002-01', '2002-02')
GROUP BY P.PROD_CATEGORY, T.CALENDAR_MONTH_DESC
UNION ALL
SELECT P.PROD_CATEGORY AS PRODUCT_CATEGORY, NULL, NULL, TO_CHAR(SUM(S.AMOUNT_SOLD), '9,999,999,999') AS SALES
FROM SALES S INNER JOIN TIMES T ON S.TIME_ID = T.TIME_ID
INNER JOIN CUSTOMERS C ON S.CUST_ID = C. CUST_ID
INNER JOIN PRODUCTS P ON S.PROD_ID = P.PROD_ID
WHERE P.PROD_CATEGORY IN ('Girls', 'Boys')  
AND T.CALENDAR_MONTH_DESC IN ('2002-01', '2002-02')
GROUP BY P.PROD_CATEGORY
UNION ALL
SELECT NULL, NULL, NULL, TO_CHAR(SUM(S.AMOUNT_SOLD), '9,999,999,999') AS SALES
FROM SALES S INNER JOIN TIMES T ON S.TIME_ID = T.TIME_ID
INNER JOIN CUSTOMERS C ON S.CUST_ID = C. CUST_ID
INNER JOIN PRODUCTS P ON S.PROD_ID = P.PROD_ID
WHERE P.PROD_CATEGORY IN ('Girls', 'Boys')  
AND T.CALENDAR_MONTH_DESC IN ('2002-01', '2002-02')
UNION ALL
SELECT P.PROD_CATEGORY AS PRODUCT_CATEGORY, NULL, C.CUST_GENDER AS GENDER, TO_CHAR(SUM(S.AMOUNT_SOLD), '9,999,999,999') AS SALES
FROM SALES S INNER JOIN TIMES T ON S.TIME_ID = T.TIME_ID
INNER JOIN CUSTOMERS C ON S.CUST_ID = C. CUST_ID
INNER JOIN PRODUCTS P ON S.PROD_ID = P.PROD_ID
WHERE P.PROD_CATEGORY IN ('Girls', 'Boys')  
AND T.CALENDAR_MONTH_DESC IN ('2002-01', '2002-02')
GROUP BY P.PROD_CATEGORY, C.CUST_GENDER
UNION ALL
SELECT NULL, T.CALENDAR_MONTH_DESC AS CALENDER_MONTH, C.CUST_GENDER AS GENDER, TO_CHAR(SUM(S.AMOUNT_SOLD), '9,999,999,999') AS SALES
FROM SALES S INNER JOIN TIMES T ON S.TIME_ID = T.TIME_ID
INNER JOIN CUSTOMERS C ON S.CUST_ID = C. CUST_ID
INNER JOIN PRODUCTS P ON S.PROD_ID = P.PROD_ID
WHERE P.PROD_CATEGORY IN ('Girls', 'Boys')  
AND T.CALENDAR_MONTH_DESC IN ('2002-01', '2002-02')
GROUP BY T.CALENDAR_MONTH_DESC, C.CUST_GENDER
UNION ALL
SELECT NULL, NULL, C.CUST_GENDER AS GENDER, TO_CHAR(SUM(S.AMOUNT_SOLD), '9,999,999,999') AS SALES
FROM SALES S INNER JOIN TIMES T ON S.TIME_ID = T.TIME_ID
INNER JOIN CUSTOMERS C ON S.CUST_ID = C. CUST_ID
INNER JOIN PRODUCTS P ON S.PROD_ID = P.PROD_ID
WHERE P.PROD_CATEGORY IN ('Girls', 'Boys')  
AND T.CALENDAR_MONTH_DESC IN ('2002-01', '2002-02')
GROUP BY C.CUST_GENDER
UNION ALL
SELECT NULL, T.CALENDAR_MONTH_DESC AS CALENDER_MONTH, NULL, TO_CHAR(SUM(S.AMOUNT_SOLD), '9,999,999,999') AS SALES
FROM SALES S INNER JOIN TIMES T ON S.TIME_ID = T.TIME_ID
INNER JOIN CUSTOMERS C ON S.CUST_ID = C. CUST_ID
INNER JOIN PRODUCTS P ON S.PROD_ID = P.PROD_ID
WHERE P.PROD_CATEGORY IN ('Girls', 'Boys')  
AND T.CALENDAR_MONTH_DESC IN ('2002-01', '2002-02')
GROUP BY T.CALENDAR_MONTH_DESC
ORDER BY 1,2,3;


Spool off
