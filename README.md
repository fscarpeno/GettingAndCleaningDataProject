# GettingAndCleaningDataProject

This project is part of the course of getting and cleaning data project.
The project contains the file "analysis_data.R" which contains the function that performs the calculations and persists the results of both the analysis and the codebook of the results file. The script that launches the function with its input parameters ( "launch.R").
It also contains the results obtained ( "output.csv") and the code table ( "codebook.csv").

The function that performs the analysis (runAnalysis) has as input parameters the path where the data file is decompressed, the path where to leave the results file, the path where to leave the table of codes and the separator character used in the files departure.
The output file contains the mean of all the variables that are mean or deviation by subject and activity, joining data of entranamiento and of test.
The code table contains the following fields, class, min, max, mean, sd y levels
