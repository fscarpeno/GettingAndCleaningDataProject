rm(list=ls())

pathFile <- "C:/workspace/R/Clean/week4/Ex/run_analysis.R"

source(pathFile)
runAnalysis("C:/workspace/R/Clean/week4/Ex/UCI HAR Dataset",
		"C:/workspace/R/Clean/week4/Ex/output.csv",
		"C:/workspace/R/Clean/week4/Ex/CodeBook.md",
		",")
