# Sales_history_datawarehousing
# SCENARIO
SH is a sample database schema provided by Oracle, which has been extensively used in the Oracle’s Data Warehousing Guide. The SH schema, as shown in the attached image, consists of a big fact table, SALES, and five relatively small dimension tables: TIMES, PROMOTIONS, CHANNELS, PRODUCTS and CUSTOMERS. The additional COUNTRIES table linked to CUSTOMERS creates a simple snowflake. The model and the attributes are aimed at demonstrating data warehousing functionality like star transformation and query rewrite. They do not necessarily represent the optimal approach for this kind of data warehouse in real productive environments; and such a design would be driven more by business requirements than by the star itself. 
