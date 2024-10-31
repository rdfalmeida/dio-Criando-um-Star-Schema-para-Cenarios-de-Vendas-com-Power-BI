# dio-Criando-um-Star-Schema-para-Cenarios-de-Vendas-com-Power-BI
Entrega do desafio Criando um Star Schema para Cenários de Vendas com Power BI

This star schema is designed for analyzing professor-related data within a university setting. The central table, Fact_Professor, holds key metrics and references related to professors, including details on courses taught, departments, and academic activities. Supporting this fact table are dimension tables:

Dim_Professor: Provides detailed attributes for each professor, such as name, title, and specialization.
Dim_Course: Describes courses with attributes like course name, level, and credits.
Dim_Department: Outlines departments with information on department names and faculties.
Dim_Date: A date dimension for tracking course offerings and other events with flexible granularity.
This structure enables effective querying and analysis, such as evaluating professor performance across courses or comparing departmental activity.
