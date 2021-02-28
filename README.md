# gettingandcleaning
Repository for Course Project "Getting and Cleaning Data"

This repository contains: R Script with the analysis performed, final tidy data set, codebook, and this readme file.

The R script will do the following:

1. Downloads the dataset compressed file if not available 
2. Unzips compressed file if directory does not already exists
3. Merges the training and test data sets into one
4. Loads appropiate lables into data sets
5. Selects and extracts variables that matches requiered: mean, std.
6. Labels variables according to descriptive variable names
7. Creates an independent data set by Subject and Activity

Scripts requieres library "reshape2"
