
## How the R script works

## Tasks carried out by the run_analysis.R script

* Read X and Y data (test and train)
* Read the feature set and activity labels, and also subject list
* filter X (test&train) wrt certain set of features and Y (test&train) should be a set of values of activity_id and activity_label
* subjects is the set of subject ids subjected to the experiment. 
* Combine X , Y with subject to create a data set which describes subject_id, activity_id, activity_label along with the different measurements obtained from that activity 
* Now we have training and test data. This is combined row wise to one data frame
* This data frame is melted into a  tall and lean data set using melt function, maintaining subject, activity_label and id as ID Variables and others as measurement vars
* The melted data frame is casted into an dataframe with ID Variables and Mean of each of measurement variables.