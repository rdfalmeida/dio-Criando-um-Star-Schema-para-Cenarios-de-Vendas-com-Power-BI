
-- Drop existing tables if they exist
DROP TABLE IF EXISTS Fact_Professor_Analysis;
DROP TABLE IF EXISTS Dim_Date;
DROP TABLE IF EXISTS Dim_Professor;
DROP TABLE IF EXISTS Dim_Course;
DROP TABLE IF EXISTS Dim_Department;

-- Dimension Table: Dim_Date
CREATE TABLE Dim_Date (
    DateID INT PRIMARY KEY,
    Date DATE NOT NULL,
    Month INT NOT NULL,
    Year INT NOT NULL,
    Semester VARCHAR(10) NOT NULL
);

-- Dimension Table: Dim_Professor
CREATE TABLE Dim_Professor (
    ProfessorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    HireDate DATE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Dim_Department(DepartmentID)
);

-- Dimension Table: Dim_Course
CREATE TABLE Dim_Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    Description TEXT
);

-- Dimension Table: Dim_Department
CREATE TABLE Dim_Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL
);

-- Fact Table: Fact_Professor_Analysis
CREATE TABLE Fact_Professor_Analysis (
    FactID INT PRIMARY KEY,
    ProfessorID INT,
    CourseID INT,
    DepartmentID INT,
    DateID INT,
    NumberOfCourses INT,
    TotalHoursTaught INT,
    TotalSalary DECIMAL(10, 2),
    FOREIGN KEY (ProfessorID) REFERENCES Dim_Professor(ProfessorID),
    FOREIGN KEY (CourseID) REFERENCES Dim_Course(CourseID),
    FOREIGN KEY (DepartmentID) REFERENCES Dim_Department(DepartmentID),
    FOREIGN KEY (DateID) REFERENCES Dim_Date(DateID)
);
