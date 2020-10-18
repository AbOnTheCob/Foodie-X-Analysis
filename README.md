# Foodie-X-Analysis

In order to analyze the given data set, I wrote an R script that reads the csv and makes certain observations. 

First, I created a scoring system called the FoodieX_Score, that takes into account both the rating of a restaurant, as well as the number of reviews. This was calculated using the equation:
    
    FoodieX_Score = Rating + 0.001(Reviews)

This will be helpful for a consumer who is looking for a reputable restaurant with a good rating, rather than having to rely on possibly skewed results if the amount of reviews is small. Something that should be noted is that new restaurants that do not have ratings will not have a FoodieX Score, and will instead be listed as NA in that column. Based on this parameter, the top 5 restaurants and their attributes are:

1) ID_1064: FoodieX Score of 11.204, based on 6,504 reviews with an average of 4.7 stars
2) ID_1666: FoodieX Score of 8.589, based on 3,989 reviews with an average of 4.6 stars
3) ID_2051: FoodieX Score of 7.059, based on 2,359 reviews with an average of 4.7 stars
4) ID_2885: FoodieX Score of 6.847, based on 2,547 reviews with an average of 4.3 stars
5) ID_6511: FoodieX Score of 6.476, based on 2,576 reviews with an average of 3.9 stars

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

The second observation I decided to analyze from the dataset is the Convenience Rating of each restaurant. This was calculated based on the Average Price at a given restaurant, along with the estimated Cook Time of a meal, using the equation:
    
    Convenience_Rating = Average_Cost + (Cook_Time - 45 minutes)

Here, a lower Convenience Rating means a restaurant is more "convenient," and as we will see, many restaurants even have a negative Convenience Rating. I used 45 minutes as the base Cooking Time, and restaurants with a Cook Time of 45 minutes are neither punished nor benefitted on the Convenience scale. Any restaurants with less than 45 minutes Cook Time are rewarded on the scale, and restaurants with more than 45 minutes Cook Time have a worse Convenience Rating as a result. Additionally, restaurants with lower average cost, obviously have a better convenience rating. This will be useful for customers who are looking for a combination of a cheap and fast meal. Most of the restaurants with a low Convenience Rating, I would view as "fast food." Surprisingly enough, many of the restaurants labelled as fast food have a relatively high convenience rating, and so despite the label, I would not consider them as such. With that being said, here are the top 5 restaurants that are the "most convenient:"

1) ID_3209: Convenience Rating of -25, based on a $10 average cost and a 10 minute cook time
2) ID_378: Convenience Rating of -20, based on a $15 average cost and a 10 minute cook time
3) ID_3670: Convenience Rating of -15, based on a $10 average cost and a 20 minute cook time
4) ID_2376: Convenience Rating of -10, based on a $5 average cost and a 30 minute cook time
5) ID_5969: Convenience Rating of -10, based on a $5 average cost and a 30 minute cook time

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

The next observation I decided to analyze was the proximities of the restaurants. For each restaurant, I figured out the amount of other restaurants that were within 0.1 units. The distance between two restaurants was found by the equation:
    Distance = sqrt((latitude1 - latitude2) ^ 2 + (longtitude1 - longtitude2) ^ 2)

I chose 0.1 as the distance threshold because this was the distance I decided produced significant enough results to make useful observations from. If the threshold was higher, the restaurants were all close to a very large number of other restaurants, defeating the purpose of the analysis. Also, 0.1 longtitudinal or latitudinal degrees is roughly equal to just under 7 miles, which is a very reasonable delivery distance.

I believe that the company can use this information to determine potential "hotspots" in delivery sites. They then know to concentrate their efforts around these places, and drivers can also know to wait around these areas when they are waiting for orders, as they are likely to be close to a larger amount of restaurants.

Here are the top 5 restaurants in terms of proximity to other restaurants:

1) ID_8522: Close to 83 other restaurants
2) ID_4906: Close to 83 other restaurants
3) ID_7544: Close to 82 other restaurants
4) ID_6128: Close to 82 other restaurants
5) ID_7131: Close to 82 other restaurants

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

The last observation I made was calculating the "value" for each restaurant. This tells users the value a restaurant provides for their money, through the equation:

    Value = FoodieX_Score / Average_Cost
    
This is very useful for users who are looking for a high quality, reputable meal, similar to the FoodieX rating, but also want a more affordable meal, or one that provides the most value for their money. Like the FoodieX_Score, the Value will be NA for new restaurants with no ratings.

Here is a list of the 5 restaurants that provide the most value:

1) ID_635: Value of 0.9958, based on a FoodieX Score of 4.979 and an average cost of $5
2) ID_635: Value of 0.9958, based on a FoodieX Score of 4.979 and an average cost of $5
3) ID_4267: Value of 0.8686, based on a FoodieX Score of 4.343 and an average cost of $5
4) ID_8287: Value of 0.8238, based on a FoodieX Score of 4.119 and an average cost of $5
5) ID_1517: Value of 0.8170, based on a FoodieX Score of 4.085 and an average cost of $5

     ï..Restaurant Latitude Longitude                  Cuisines Average_Cost Minimum_Order Rating Votes Reviews
702         ID_635 39.74808 -85.73557                    Mishti        $5.00        $99.00    4.4  1512     579
1262        ID_635 39.44685 -85.02729                    Mishti        $5.00        $99.00    4.4  1512     579
1432       ID_4267 39.77516 -85.28479 Street Food, South Indian        $5.00         $0.00    4.2   765     143
1845       ID_8287 39.61642 -85.10699              South Indian        $5.00        $50.00    4.1   141      19
1943       ID_1517 39.34658 -85.28478              North Indian        $5.00        $50.00    4.0   305      85
      Cook_Time FoodieX_Score Convenience_Rating Restaurants_Within_0.1_Units  Value
702  45 minutes         4.979                  5                           61 0.9958
1262 45 minutes         4.979                  5                           48 0.9958
1432 30 minutes         4.343                -10                           59 0.8686
1845 30 minutes         4.119                -10                           66 0.8238
1943 45 minutes         4.085                  5                           72 0.8170

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

The R script used to analyze the data and make these observations is also included in this repository, under FoodieXAnalysis.R . When run, it will print the 10 best restaurants based on each observation.
Also, a new version of the dataset, with columns for each of the observations added, can be found under Foodie Ratings.csv .
