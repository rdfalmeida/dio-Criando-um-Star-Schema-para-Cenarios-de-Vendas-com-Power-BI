import pandas as pd

# Function to load data from Excel with error handling
def load_data(file_path, sheet_name):
    try:
        df = pd.read_excel(file_path, sheet_name=sheet_name)
        df.columns = df.columns.str.strip()  # Remove any leading or trailing spaces from column names
        print(f"Successfully loaded '{sheet_name}' from {file_path}.")
        return df
    except Exception as e:
        print(f"Error loading '{sheet_name}' from {file_path}: {e}")
        return None

# Load data from the original Excel file
file_path = 'Star Schema Financial Sample.xlsx'  # Update with your actual file path
sheet1_df = load_data(file_path, 'Sheet1')

if sheet1_df is not None:
    try:
        # Display the actual columns in the DataFrame for debugging
        print("Columns in Sheet1:", sheet1_df.columns.tolist())
        
        # Ensure Date column is in datetime format
        sheet1_df['Date'] = pd.to_datetime(sheet1_df['Date'], errors='coerce')

        # Create Dim_Segments
        dim_segments_df = sheet1_df[['Segment']].drop_duplicates().reset_index(drop=True)
        dim_segments_df['SegmentKey'] = dim_segments_df.index + 1
        dim_segments_df = dim_segments_df[['SegmentKey', 'Segment']]

        # Create Dim_Country
        dim_country_df = sheet1_df[['Country']].drop_duplicates().reset_index(drop=True)
        dim_country_df['CountryKey'] = dim_country_df.index + 1
        dim_country_df = dim_country_df[['CountryKey', 'Country']]

        # Create Dim_Product
        dim_product_df = sheet1_df[['Product', 'Manufacturing Price']].drop_duplicates().reset_index(drop=True)
        dim_product_df['ProductKey'] = dim_product_df.index + 1
        dim_product_df = dim_product_df[['ProductKey', 'Product', 'Manufacturing Price']]

        # Create Dim_Date
        dim_date_df = sheet1_df[['Date']].drop_duplicates().reset_index(drop=True)
        dim_date_df['Year'] = dim_date_df['Date'].dt.year
        dim_date_df['Month_Number'] = dim_date_df['Date'].dt.month
        dim_date_df['Month_Name'] = dim_date_df['Date'].dt.month_name()
        dim_date_df['Quarter'] = dim_date_df['Date'].dt.quarter
        dim_date_df = dim_date_df[['Date', 'Month_Number', 'Month_Name', 'Year', 'Quarter']]

        # Create Fact_Sales
        fact_sales_df = sheet1_df.copy()
        fact_sales_df['Sales_ID'] = fact_sales_df.index + 1

        # Drop unnecessary columns, ensure the columns exist
        fact_sales_columns = ['Sales_ID', 'Segment', 'Country', 'Product', 
                              'Discount Band', 'Units Sold', 'Manufacturing Price', 
                              'Sale Price', 'Gross Sales', 'Discounts', 
                              'Sales', 'COGS', 'Profit', 'Date', 'Year']

        # Check if all required columns are present except Month_Number and Month_Name
        missing_columns = [col for col in fact_sales_columns if col not in fact_sales_df.columns]
        if missing_columns:
            print(f"Warning: The following columns are missing in Fact_Sales: {missing_columns}")
        else:
            fact_sales_df = fact_sales_df[fact_sales_columns]

        # Write to a new Excel file named modeled_star_schema_financial.xlsx
        output_file_path = 'modeled_star_schema_financial.xlsx'
        with pd.ExcelWriter(output_file_path) as writer:
            dim_segments_df.to_excel(writer, sheet_name='Dim_Segments', index=False)
            dim_country_df.to_excel(writer, sheet_name='Dim_Country', index=False)
            dim_product_df.to_excel(writer, sheet_name='Dim_Product', index=False)
            dim_date_df.to_excel(writer, sheet_name='Dim_Date', index=False)
            fact_sales_df.to_excel(writer, sheet_name='Fact_Sales', index=False)

        print(f"Data has been processed and written to {output_file_path} successfully.")

    except Exception as e:
        print(f"Error during data processing or writing to Excel: {e}")
else:
    print("Failed to load data from 'Sheet1'. Please check the error messages above.")
