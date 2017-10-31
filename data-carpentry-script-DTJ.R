# Section 1 -----------------------------
## Section 2 =================================
### Section 3 ###########################################


# Setup ----
install.packages(c("tidyverse","RSQLite"))

# Before we start ----
getwd()

?barplot
args(lm)
??kruskall

dput(head(iris))
saveRDS(iris, file="tmp/iris.rds")
some_data <- readRDS(file="tmp/iris.rds")

sessionInfo()

packageDescription("tidyverse")

# Introduction to R ----

## Creating objects in R ====

# we can use R like a calculator
3+5
12/7

# but it is more useful to assing values to objects
weight_kg <- 55   # assign value
(weight_kg <- 55) # display value after assignment
weight_kg         # display value

2.2*weight_kg
weight_kg <- 57.5
2.2*weight_kg

weight_lb <- 2.2*weight_kg

weight_kg <- 100

### Challenge ####
##
## What are the values after each statement in the following?
##
mass <- 47.5            # mass?
age  <- 122             # age?
mass <- mass * 2.0      # mass?
age  <- age - 20        # age?
mass_index <- mass/age  # mass_index?

## Functions and thier arguments ====
a <- 2
b <- sqrt (a)

round(3.14159)
args(round)

round(3.14159, digits=2)
round(3.14159, 2)
round(digits=2, x=3.14159)

### Vectors and data types ====
weight_g <- c(50,60,65,82)
weight_g

animals <- c("mouse","rat","dog")
animals

length(weight_g)
length(animals)

class(weight_g)
class(animals)

str(weight_g)
str(animals)

# c() is a very useful fundtion!
weight_g <- c(weight_g, 90) # add to end of the vector
weight_g <- c(30, weight_g) # add to beginning of the vector
weight_g

### Challenge ####
## ## We’ve seen that atomic vectors can be of type character, numeric, integer, and
## ## logical. But what happens if we try to mix these types in a single vector?
#>>>> Each vector will be coerced into a common data type
## 
## ## What will happen in each of these examples? (hint: use `class()` to
## ## check the data type of your object)
num_char <- c(1, 2, 3, "a")
class(num_char)
#>>>> Coerced to character data type
## 
num_logical <- c(1, 2, 3, TRUE)
class(num_logical)
#>>>> Coerced to numeric data type
## 
char_logical <- c("a", "b", "c", TRUE)
class(char_logical)
#>>>> Coerced to character data type
## 
tricky <- c(1, 2, 3, "4")
class(tricky)
#>>>> Coerced to character data type
## 
## ## Why do you think it happens?
#>>>> R needs a common data type in order to work with vectors
## 
## ## You've probably noticed that objects of different types get
## ## converted into a single, shared type within a vector. In R, we call
## ## converting objects from one class into another class
## ## _coercion_. These conversions happen according to a hierarchy,
## ## whereby some types get preferentially coerced into other types. Can
## ## you draw a diagram that represents the hierarchy of how these data
## ## types are coerced?
#>>>> Objects are coerced to the most flexible common data type
#>>>> In order from least flexible to most felxible:
#>>>> Logical --> Integer (long) --> Numeric (double) --> Character

## Subsetting vectors ====
animals <- c("mouse", "rat", "dog", "cat")
animals <- c(animals, "cat") # take advantage of our earlier work

animals[2]
animals[c(3,2)]

more_animals <- animals[c(1,2,3,2,1,4)]
more_animals

## Conditional subsetting ====
weight_g <- c(21,34,39,54,55)
weight_g[c(TRUE,FALSE,TRUE,TRUE,FALSE)]

weight_g > 50

## so we can use this to select only the values above 50
weight_g[weight_g>50]

## Use | for OR
weight_g[weight_g<30 | weight_g>50]

## Use & for AND
weight_g[weight_g>=30 & weight_g==21]

animals
animals[animals=="cat" | animals=="rat"]

animals %in% c("rat","cat","dog","duck","goat")

animals[animals %in% c("rat","cat","dog","duck","goat")]

### Challenge (optional) ####
##
## * Can you figure out why `"four" > "five"` returns `TRUE`?
#>>>> Character ASCII value comparison instead of numeric

## Missing data ====
heights <- c(2,4,4,NA,6)
mean(heights)
max(heights)
mean(heights, na.rm=TRUE)
max(heights, na.rm=TRUE)

# extract elements that are NOT missing values
# ! is the NOT operator
heights[!is.na(heights)]

# return an object with incomplete cases removed
na.omit(heights)

# extract only those elements that are complete cases
heights[complete.cases(heights)]
mean(heights[complete.cases(heights)])

### Challenge ####
## 1. Using this vector of length measurements, create a new vector with the NAs
## removed.
##
lengths <- c(10,24,NA,18,NA,20)
new_lengths <- lengths[complete.cases(lengths)]
typeof(new_lengths)
## 2. Use the function `median()` to calculate the median of the `lengths` vector.
median(new_lengths)

# Starting with data ----

## Presentation of the iDigBio data ====
download.file("https://ndownloader.figshare.com/files/9582724",
               "data/idigbio_rodents.csv")

specimens <- read.csv("data/idigbio_rodents.csv")

specimens
head(specimens)

## What are data frames ====
str(specimens)

## Inspecting data.frame objects
dim(specimens)
nrow(specimens)
ncol(specimens)
head(specimens)
tail(specimens)
names(specimens)
colnames(specimens)
rownames(specimens)
str(specimens)
summary(specimens)

### Challenge ####
## Based on the output of `str(specimens)`, can you answer the following questions?
## * What is the class of the object `specimens`?
#>>>> data.frame
## * How many rows and how many columns are in this object?
## * How many genera are represented by these specimens?

## Indexing and subsetting data frames ====
specimens[1,1]   # first element in 1st column
specimens[1,6]   # first element in 6th column
specimens[,1]    # first column as a vector
specimens[1]     # first column as a data frame
specimens[1:3,7] # first 3 elements of 7th column
specimens[3,]    # 3rd element for all columns
head_specimens <- specimens[1:6,] # equivalent to head(specimens)

specimens[,-1] # everything except the first column
specimens[-c(7:10767),] # equivalent to head(specimens)

specimens["genus"]   # as data.frame
specimens[,"genus"]  # as vector
specimens[["genus"]] # as vector
specimens$genus      # as vector

### Challenges: ####
###
### 1. Create a `data.frame` (`specimens_200`) containing only the
###    observations from row 200 of the `specimens` dataset.
###
specimens_200 <- specimens[200,]
specimens_200
### 2. Notice how `nrow()` gave you the number of rows in a `data.frame`?
###
###      * Use that number to pull out just that last row in the data frame
nrow(specimens)
specimens[10767,]
###      * Compare that with what you see as the last row using `tail()` to make
###        sure it's meeting expectations.
tail(specimens)
###      * Pull out that last row using `nrow()` instead of the row number
specimens[nrow(specimens),]
###      * Create a new data frame object (`specimens_last`) from that last row
specimens_last <- specimens[nrow(specimens),]
specimens_last
###
### 3. Use `nrow()` to extract the row that is in the middle of the
###    data frame. Store the content of this row in an object named
###    `specimens_middle`.
specimens_middle <- specimens[nrow(specimens)/2,]
specimens_middle
###
### 4. Combine `nrow()` with the `-` notation above to reproduce the behavior of
###    `head(specimens)` keeping just the first through 6th rows of the specimens
###    dataset.
specimens[-c(7:nrow(specimens)),]

## Factors ====
sex <- factor(c("male", "female", "female", "male"))
levels(sex)
nlevels(sex)
sex # current order

sex <- factor(sex, levels = c("male", "female"))
sex # after re-ordering

## Converting factors ====
as.character(sex) # convert to character vector

f <- factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(f)               # wrong! and there is no warning...
as.numeric(as.character(f)) # works...
as.numeric(levels(f))[f]    # The recommended way

## Renaming factors ====
## bar plot of the number of females and males captured during the experiment:
plot(specimens$sex)

sex <- specimens$sex
head(sex)
levels(sex)

levels(sex)[1] <- "missing"
levels(sex)
head(sex)

plot(sex)

## Challenges ####
##
## * Rename "female" and "male" to "F" and "M" respectively.
levels(sex)[2] <- "F"
levels(sex)[3] <- "M"
levels(sex)
## * Now that we have renamed the factor level to "missing", can you recreate the
##   barplot such that "missing" is last (after "M")
sex <- factor(sex, levels = c("F", "M", "missing"))
plot(sex)

## Using stringsAsFactors=FALSE ====
# Compare the diffference between data read as factor vs character
str(specimens)
specimens <- read.csv("data/idigbio_rodents.csv", stringsAsFactors = FALSE)
str(specimens)

# Convert "genus" to a factor
specimens$genus <- factor(specimens$genus)
str(specimens$genus)

## ## Challenge: ####
## ##  1. There are a few mistakes in this hand-crafted `data.frame`,
## ##  can you spot and fix them? Don't hesitate to experiment!
animal_data <- data.frame(animal=c("dog", "cat", "sea cucumber", "sea urchin"),
                         feel=c("furry", "furry", "squishy", "spiny"),
                         weight=c(45, 8, 1.1, 0.8))
#>>>> missing quotes around animal names
#>>>> missing comma between 8 and 1.1
#>>>> missing element in feel for dog or cat
## ##   2. Can you predict the class for each of the columns in the following
## ##   example?
## ##   Check your guesses using `str(country_climate)`:
## ##   * Are they what you expected? Why? why not?
## ##   * What would have been different if we had added `stringsAsFactors = FALSE`
## ##     to this call?
## ##   * What would you need to change to ensure that each column had the
## ##     accurate data type?
country_climate <- data.frame(country=c("Canada", "Panama", "South Africa", "Australia"),
                              climate=c("cold", "hot", "temperate", "hot/temperate"),
                              temperature=c(10, 30, 18, "15"),
                              northern_hemisphere=c(TRUE, TRUE, FALSE, "FALSE"),
                              has_kangaroo=c(FALSE, FALSE, FALSE, 1))
str(country_climate)

country_climate <- data.frame(country=c("Canada", "Panama", "South Africa", "Australia"),
                              climate=c("cold", "hot", "temperate", "hot/temperate"),
                              temperature=c(10, 30, 18, "15"),
                              northern_hemisphere=c(TRUE, TRUE, FALSE, "FALSE"),
                              has_kangaroo=c(FALSE, FALSE, FALSE, 1), stringsAsFactors = FALSE)
str(country_climate)

country_climate <- data.frame(country=c("Canada", "Panama", "South Africa", "Australia"),
                              climate=c("cold", "hot", "temperate", "hot/temperate"),
                              temperature=c(10, 30, 18, 15),
                              northern_hemisphere=c(TRUE, TRUE, FALSE, FALSE),
                              has_kangaroo=c(FALSE, FALSE, FALSE, TRUE))
str(country_climate)

## Formatting Date ====
specimens <- read.csv("data/idigbio_rodents.csv", stringsAsFactors = TRUE)
str(specimens)

library(lubridate)
# note that R will mask certian functions if they are present in multiple packages
# R will defualt to the most-recently installed package
# you can specify which package to use by package::function
# if you want the base R function, use base::function

# create a cahracter vector from year, month, day
paste(specimens$year, specimens$month, specimens$day, sep="-")
ymd(paste(specimens$year, specimens$month, specimens$day, sep="-"))

# add this to the specimens data frame
specimens$date <- ymd(paste(specimens$year, specimens$month, specimens$day, sep="-"))
str(specimens)

# Manipulating and analyzing data with dplyr ----
library(tidyverse)

## Selecting columns and filtering rows ====
select(specimens, institutionCode, genus, weight)
filter(specimens, year == 1995)

## Pipes ====
specimens %>%
  filter(weight < 50) %>%
  select(genus, sex, weight)

specimens_sml <- specimens %>%
  filter(weight < 50) %>%
  select(genus, sex, weight)
specimens_sml

## ## Pipes Challenge: ####
## ##  Using pipes, subset the data to include individuals collected
## ##  before 1995, and retain the columns `year`, `sex`, and `weight.`
specimens %>%
  filter(year < 1995) %>%
  select(year, sex, weight)



## Mutate ====
specimens %>%
  mutate(weight_kg = weight / 1000)

specimens %>%
  mutate(weight_kg = weight / 1000,
         weight_kg2 = weight_kg *2)

specimens %>%
  mutate(weight_kg = weight / 1000) %>%
  head

specimens %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight / 1000) %>%
  head

## ## Mutate Challenge: ####
## ##  Create a new data frame from the `specimens` data that meets the following
## ##  criteria: contains only the `scientificName` column and a column that
## ##  contains values that are half the `weight` values (e.g. a
## ##  new column `weight_half`). In this `weight_half` column, there are
## ##  no NA values and all values are < 30.
## 
## ##  Hint: think about how the commands should be ordered to produce this data frame!
## 
specimens_mutate <- specimens %>%
  filter(!is.na(weight) & weight < 30) %>%
  mutate(weight_half = weight /2) %>%
  select(scientificName, weight_half)
specimens_mutate





## ## Tally Challenges:
## ##  1. How many individuals were caught in each `stateProvince` surveyed?
## 
## ##  2. Use `group_by()` and `summarize()` to find the mean, min, and
## ##  max length for each species (using `scientificName`).
## 
## ##  3. What was the heaviest animal measured in each year? Return the
## ##  columns `year`, `genus`, `scientificName`, and `weight`.
## 
## ## 4. You saw above how to count the number of individuals of each `sex` using a
## ## combination of `group_by()` and `tally()`. How could you get the same result
## ## using `group_by()` and `summarize()`? Hint: see `?n`.
## 
## ## Reshaping challenges
## 
## ## 1. Make a wide data frame with `year` as columns, `stateProvince`` as rows, and the values are the number of genera per state. You will need to summarize before reshaping, and use the function `n_distinct` to get the number of unique types of a genera. It's a powerful function! See `?n_distinct` for more.
## 
## ## 2. Now take that data frame, and make it long again, so each row is a unique `stateProvince` `year` combination
## 
## ## 3. The `specimens` data set is not truly wide or long because there are two columns of measurement - `length` and `weight`.  This makes it difficult to do things like look at the relationship between mean values of each measurement per year in different plot types. Let's walk through a common solution for this type of problem. First, use `gather` to create a truly long dataset where we have a key column called `measurement` and a `value` column that takes on the value of either `length` or `weight`. Hint: You'll need to specify which columns are being gathered.
## 
## ## 4. With this new truly long data set, calculate the average of each `measurement` in each `year` for each different `stateProvince`. Then `spread` them into a wide data set with a column for `length` and `weight`. Hint: Remember, you only need to specify the key and value columns for `spread`.
## 
## ### Create the dataset for exporting:
## ##  Start by removing observations for which the `scientificName`, `weight`,
## ##  `length`, or `sex` data are missing:
## specimens_complete <- specimens %>%
##   filter(scientificName != "",        # remove missing scientificName
##   !is.na(weight),                 # remove missing weight
## 		  !is.na(length),        # remove missing length
## 		  sex != "")                      # remove missing sex
## 
## ##  Now remove rare species in two steps. First, make a list of species which
## ##  appear at least 50 times in our dataset:
## species_counts <- specimens_complete %>%
##               group_by(scientificName) %>%
##               tally %>%
## 				          filter(n >= 50) %>%
## 				          select(scientificName)
## 
## ##  Second, keep only those species:
## specimens_complete <- specimens_complete %>%
##              filter(scientificName %in% species_counts$scientificName)
## 


### Data Visualization with ggplot2
## install.packages("hexbin")
## specimens_plot +
##  geom_hex()
## ### Challenge with hexbin
## ##
## ## To use the hexagonal binning with **`ggplot2`**, first install the `hexbin`
## ## package from CRAN:
## 
## install.packages("hexbin")
## 
## ## Then use the `geom_hex()` function:
## 
## specimens_plot +
##     geom_hex()
## 
## ## What are the relative strengths and weaknesses of a hexagonal bin
## ## plot compared to a scatter plot?
## ### Challenge with scatter plot:
## ##
## ##  Use what you just learned to create a scatter plot of `weight`
## ## over `scientificName` with the genera showing in different colors.
## ## Is this a good way to show this type of data?
## ## Challenge with boxplots:
## ##  Start with the boxplot we created:
## ggplot(data = specimens_complete, aes(x = scientificName, y = weight)) +
##   geom_boxplot(alpha = 0) +
##   geom_jitter(alpha = 0.3, color = "tomato")
## 
## ##  1. Replace the box plot with a violin plot; see `geom_violin()`.
## 
## ##  2. Represent weight on the log10 scale; see `scale_y_log10()`.
## 
## ##  3. Create boxplot for `length` overlaid on a jitter layer.
## 
## ##  4. Add color to the datapoints on your boxplot according to the
## ##  month from which the specimen was taken (`month`).
## ##  Hint: Check the class for `month`. Consider changing the class
## ##  of `month` from integer to factor. Why does this change how R
## ##  makes the graph?
## 
## ### Plotting time series challenge:
## ##
## ##  Use what you just learned to create a plot that depicts how the
## ##  average weight of each species changes through the years.
## 
## ### Final plotting challenge:
## ##  With all of this information in hand, please take another five
## ##  minutes to either improve one of the plots generated in this
## ##  exercise or create a beautiful graph of your own. Use the RStudio
## ##  ggplot2 cheat sheet for inspiration:
## ##  https://www.rstudio.com/wp-content/uploads/2015/08/ggplot2-cheatsheet.pdf


## SQL databases and R
## install.packages("dbplyr")
## library(dbplyr)
library(dplyr)
rodents <- src_sqlite("data/idigbio_rodents.sqlite")
rodents
tbl(rodents, sql("SELECT year, speciesID, localityID FROM specimens"))
specimens <- tbl(rodents, "specimens")
specimens %>%
    select(year, speciesID, localityID)

### Challenge
## Write a query that returns the number of dipodomys at each institution
## in each year.

##  Hint: Connect to the species table and write a query that joins
##  the species and specimen tables together to exclude all
##  non-dipodomys genera. The query should return counts of specimens by year.

## Optional: Write a query in SQL that will produce the same
## result. You can join multiple tables together using the following
## syntax where foreign key refers to your unique id (e.g.,
## `speciesID`):

## SELECT table.col, table.col
## FROM table1 JOIN table2
## ON table1.key = table2.key
## JOIN table3 ON table2.key = table3.key

## with dplyr syntax
species <- tbl(rodents, "species")

left_join(specimens, species) %>%
  filter(genus == "dipodomys") %>%
  group_by(institutionCode, year) %>%
  tally %>%
  collect()

## with SQL syntax
query <- paste("
SELECT a.year, b.genus, count(*) as count
FROM specimens a
JOIN species b
ON a.speciesID = b.speciesID
AND b.genus = 'dipodomys'
GROUP BY a.year, a.institutionCode",
sep = "" )

tbl(rodents, sql(query))

### Challenge

## Write a query that returns the total number of rodents in each
## genus caught in the different states.

##  Hint: Write a query that joins the species, locality, and specimens
##  tables together.  The query should return counts of genus by state.
genus_counts <- left_join(specimens, localities) %>%
  left_join(species) %>%
  group_by(stateProvince, genus) %>%
  tally %>%
  collect()
species <- read.csv("data/species.csv")
specimens <- read.csv("data/specimens.csv")
localities <- read.csv("data/localities.csv")
my_db_file <- "my_rodent_database.sqlite"
my_db <- src_sqlite(my_db_file, create = TRUE)
my_db
### Challenge

## Add the remaining species table to the my_db database and run some
## of your queries from earlier in the lesson to verify that you
## have faithfully recreated the rodents database.


