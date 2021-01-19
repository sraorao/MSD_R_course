###R for biologists
##Irina & Rao, 20/01/2021

# https://www.nature.com/articles/sdata20179
# Article title: Systematic high-content genome-wide RNAi screens of endothelial 
# cell migration and morphology 
### ABSTRACT: Here, we present a dataset containing siRNA screens that identify known and 
### novel components of signalling pathways regulating migration of lymphatic 
### endothelial cells... using high-content microscopy, we captured a dataset 
### of images of migrating cells following transfection with a genome-wide siRNA
### library.
# Data downloaded from: https://pubchem.ncbi.nlm.nih.gov/bioassay/1159618
# and https://pubchem.ncbi.nlm.nih.gov/bioassay/1159617


#### LOAD and PREPARE data ####
# We will subset the data downloaded from the above source 
# to simplify our analysis

# Load migration data
# We are only interested in columns 8, 9, 10, 13
# We are also NOT interested in rows 1, 2
migration_data = read.csv("Session2/AID_1159618_datatable_all.csv")
migration_data = migration_data[c(-1, -2), c(8, 10, 13)]
colnames(migration_data) = c("reagent_id", "gene_symbol", "migration")
dim(migration_data)
head(migration_data)

# Load morphology data
# We are only interested in columns 8, 9, 10, 19
# We are also NOT interested in rows 1, 2
morphology_data = read.csv("Session2/AID_1159617_datatable_all.csv")
morphology_data = morphology_data[c(-1, -2), c(8, 10, 19)]
colnames(morphology_data) = c("reagent_id", "gene_symbol", "elongatedness")
dim(morphology_data)
head(morphology_data)

#### MERGE migration and morphology data ####
complete_migmorph = merge(migration_data, morphology_data, 
                          by = c("reagent_id", "gene_symbol"))
colnames(complete_migmorph)
head(complete_migmorph)
str(complete_migmorph)

complete_migmorph$migration = as.numeric(complete_migmorph$migration)
complete_migmorph$elongatedness = as.numeric(complete_migmorph$elongatedness)
#### Explore data DISTRIBUTION ####
hist(complete_migmorph$migration) 
hist(complete_migmorph$migration, breaks = 10)

plot(density(complete_migmorph$migration))

# Q: Plot data distribution graphs for elongatedness

hist(complete_migmorph$elongatedness)
plot(density(complete_migmorph$elongatedness))

#### Calculate basic STATS for this dataset: mean, median, standard deviation ####

mean(complete_migmorph$migration)
median(complete_migmorph$migration)

# Q: Calculate the standard deviation for migration
# # hint: Find out which function can be used to calculate standard deviation
# # by typing ??"standard deviation" in the console



#### DETOUR: How to handle NAs ####
?airquality
head(airquality)
airquality$Ozone
mean(airquality$Ozone)
mean(airquality$Ozone, na.rm = TRUE)
median(airquality$Ozone, na.rm = TRUE)

# Not all functions have the na.rm argument; what to do then?
which_rows_complete = complete.cases(airquality)
airquality[which_rows_complete, ]

ozone_without_missing = na.omit(airquality$Ozone)

#### Explore the RELATIONSHIP between migration and elongatedness ####

plot(complete_migmorph$migration, complete_migmorph$elongatedness)

# Calculate Pearson's correlation coefficient

cor.test(complete_migmorph$migration, complete_migmorph$elongatedness)

# Q: Calculate Spearman correlation coefficient
# # hint: Look up the help pages for cor.test() function

# Q: Knockdown of which gene causes the cells to migrate the least?

#### FILTERING data ####
# Subsetting by logical vectors comes in handy here
# Knockdown of which genes results in migration > 1?

which_rows_mig1 = complete_migmorph$migration > 1
complete_migmorph[which_rows_mig1, ]

which_rows_elongatedness1.5 = complete_migmorph$elongatedness < 1.5
complete_migmorph[which_rows_elongatedness1.5, ]

#### Problem set ####
# Q: Knockdown of which gene results in the highest migration?
# # hint: this can be accomplished with the max() function
