# dio-Criando-um-Star-Schema-para-Cenarios-de-Vendas-com-Power-BI
Entrega do desafio Criando um Star Schema para Cenários de Vendas com Power BI

Overview: Transforming Raw Data into a Star Schema
This project involved transforming a raw data sheet (Sheet1) into a structured star schema format, which is ideal for analysis in tools like Power BI. We used Python and AI to automate the transformation process and generated two scripts for loading, organizing, and saving the data in Excel.

Step-by-Step Transformation Process
1. Initial Data (Sheet1)
Source: The starting data was located in a single sheet called Sheet1 in an Excel file.
Columns: It contained a mix of raw data for various dimensions, such as:
Segment, Country, Product, Discount Band, Units Sold, Manufacturing Price, Sale Price, Gross Sales, Discounts, Sales, COGS, Profit, Date, Month Number, Month Name, and Year.
This format was useful for storing raw information but wasn't optimized for analytical processing due to data redundancy and lack of relational structure.

2. Transformation with AI and Python
We applied an AI-assisted script to read, clean, and distribute Sheet1 data into multiple tables according to star schema principles. Specifically, Python handled data extraction, validation, and error handling.
Two Python scripts were generated:
Script 1: Loaded Sheet1 and separated data into dimension and fact tables.
Script 2: Created an updated Excel file (modeled_star_schema_financial.xlsx) with distinct sheets, each representing a table in the star schema. This file overwrites any previous version if it exists.
3. Star Schema Output (modeled_star_schema_financial.xlsx)
The transformed data was split into a fact table and dimension tables, creating a relational model for efficient analysis:

Fact_Sales: This central table stores the main transaction data:

Columns include primary sales information like Sales_ID, Segment, Country, Product, Discount Band, Units Sold, Gross Sales, Discounts, Sales, COGS, Profit, and Date.
The fact table is connected to each dimension table by specific fields (Segment, Country, Product, Date).
Dimension Tables:

Dim_Segments: Contains unique segments (e.g., Channel Partners, Government).
Dim_Country: Lists countries where sales occurred.
Dim_Product: Holds product details along with manufacturing prices.
Dim_Date: Contains dates, months, quarters, and years for calendar-based analysis.
4. Result
Before: All data resided in Sheet1, unstructured and not easily analyzable.
After: Data is organized in a star schema format across multiple sheets, enabling easy integration with Power BI for visualization and analysis. Relationships can now be set up in Power BI, connecting fact and dimension tables to support detailed insights and reporting.
This setup provides a strong foundation for efficient data analysis and insights using Power BI or similar analytical tools.
