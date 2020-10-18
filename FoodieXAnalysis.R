library("tidyverse")
library("lubridate")

filein = "C:/Users/usant/Downloads/2020-XTern-DS.csv"

df = read.csv(filein, header = TRUE)

#initialize the four observation vectors with a 0 placeholder at the front
myscores <- 0
conveniences <- 0
distances <- 0
values <- 0
i = 1

#loop through each row of the dataset, calculating and appending each observation
while (i <= nrow(df)) {
  rating = as.numeric(df$Rating[i])
  reviews = as.numeric(df$Reviews[i])
  score = rating + 0.001*reviews
  myscores <- append(myscores, score)
  
  cookTime = as.numeric(substr(df$Cook_Time[i], 1, str_locate(df$Cook_Time[i], " ")[1,1]))
  averageCost = as.numeric(substr(df$Average_Cost[i], 2, nchar(df$Average_Cost[i])))
  score2 = averageCost + cookTime - 45
  conveniences <- append(conveniences, score2)
  
  latitude = as.numeric(df$Latitude[i])
  longtitude = as.numeric(df$Longitude[i])
  j = 1
  numprox = 0
  while (j <= nrow(df)) {
    latitude2 = as.numeric(df$Latitude[j])
    longtitude2 = as.numeric(df$Longitude[j])
    distance = sqrt((latitude-latitude2)^2 + (longtitude-longtitude2)^2)
    if (distance <= 0.1) {
      numprox = numprox + 1
    }
    j = j + 1
  }
  distances <- append(distances,numprox - 1)
  
  value = score/averageCost
  values <- append(values, value)
  i = i + 1
  
}

#take out the placeholder value at the start
myscores <- myscores[-1]
conveniences <- conveniences[-1]
distances <- distances[-1]
values <- values[-1]

#add each observation back into the dataframe as a column
df <- cbind(df, FoodieX_Score = myscores)
df <- cbind(df, Convenience_Rating = conveniences)
df <- cbind(df, Restaurants_Within_0.1_Units = distances)
df <- cbind(df, Value = values)

#write the new dataframe into a new csv file
write.csv(df, file = "C:/Users/usant/Downloads/Foodie Ratings.csv")

print("Here is the top 5 restaurants based on FoodieX score (determined by both rating and number of reviews)")
head(df[order(-df$FoodieX_Score),], n = 10)

print("Here is the top 5 restaurants based on convienience rating (determined by price and meal preparation time")
head(df[order(df$Convenience_Rating),], n = 10)

print("Here is the 5 restaurants that are within 0.1 coordinate units of the most other restaurants")
head(df[order(-df$Restaurants_Within_0.1_Units),], n = 10)

print("Here is the 5 restaurants with the best value for your money")
head(df[order(-df$Value),], n = 10)

