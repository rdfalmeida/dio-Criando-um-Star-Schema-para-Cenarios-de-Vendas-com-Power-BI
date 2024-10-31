import pandas as pd
import os

# Define the Excel file and output SQL file
excel_file = 'modeled_star_schema_financial.xlsx'
output_sql_file = 'modeled_star_schema_financial.sql'

# Function to generate SQL statements
def generate_sql_from_excel(excel_path, sql_file_path):
    # Open the .sql file in write mode
    with open(sql_file_path, 'w') as sql_file:
        # Load the Excel file
        xls = pd.ExcelFile(excel_path)
        
        for sheet_name in xls.sheet_names:
            # Read each sheet into a DataFrame
            df = pd.read_excel(xls, sheet_name=sheet_name)
            
            # Write the CREATE TABLE statement
            sql_file.write(f"-- Drop table if it exists\n")
            sql_file.write(f"DROP TABLE IF EXISTS {sheet_name};\n\n")

            sql_file.write(f"-- Create table {sheet_name}\n")
            sql_file.write(f"CREATE TABLE {sheet_name} (\n")
            
            # Define columns and their data types for PostgreSQL
            columns = []
            for col in df.columns:
                if col.lower().endswith("id") or "key" in col.lower():
                    columns.append(f"    {col} SERIAL PRIMARY KEY")
                elif df[col].dtype == 'int64':
                    columns.append(f"    {col} INTEGER")
                elif df[col].dtype == 'float64':
                    columns.append(f"    {col} DECIMAL")
                elif "date" in col.lower():
                    columns.append(f"    {col} DATE")
                else:
                    columns.append(f"    {col} VARCHAR")
            
            sql_file.write(",\n".join(columns))
            sql_file.write("\n);\n\n")

            # Write the INSERT INTO statements for each row in the DataFrame
            sql_file.write(f"-- Insert data into {sheet_name}\n")
            for _, row in df.iterrows():
                # Prepare row values
                values = []
                for col, value in row.items():
                    if pd.isnull(value):
                        values.append("NULL")
                    elif isinstance(value, str):
                        values.append(f"'{value.replace("'", "''")}'")
                    elif isinstance(value, pd.Timestamp):
                        values.append(f"'{value.date()}'")
                    else:
                        values.append(str(value))

                # Join the values for an INSERT statement
                sql_file.write(
                    f"INSERT INTO {sheet_name} ({', '.join(df.columns)}) VALUES ({', '.join(values)});\n"
                )
            sql_file.write("\n\n")

    print(f"SQL file '{sql_file_path}' created successfully.")

# Run the function to generate the SQL file
generate_sql_from_excel(excel_file, output_sql_file)
