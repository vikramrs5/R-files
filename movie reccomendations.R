install.packages("recommenderlab")
install.packages("data.table")
install.packages("reshape2")
library(reshape2)
library(data.table)
library(recommenderlab)
setwd("/Users/vikramraj/Downloads")
View(movies)
View(ratings)
movie_data=data.frame(movies)
ratings_data=data.frame(ratings)
str(movie_data)
summary(movie_data)
head(movie_data)
str(ratings_data)
summary(ratings_data)
head(ratings_data)
movie_genre=as.data.frame(movie_data$genres,stringsAsFactors = FALSE)
movie_genre
movie_genre2 <- as.data.frame(tstrsplit(movie_genre[,1],'[|]',
                                        type.convert =TRUE),
                              stringsAsFactors=FALSE)
View(movie_genre2)
colnames(movie_genre2)=c(1:10)
list_genre <- c("Action", "Adventure", "Animation", "Children",
                "Comedy", "Crime","Documentary", "Drama", "Fantasy",
                "Film-Noir", "Horror", "Musical", "Mystery","Romance",
                "Sci-Fi", "Thriller", "War", "Western")
genre_mat1 <- matrix(0,10329,18)
View(genre_mat1)
genre_mat1[1,] <- list_genre
colnames(genre_mat1) <- list_genre
for (index in 1:nrow(movie_genre2)) {
  for (col in 1:ncol(movie_genre2)) {
    gen_col = which(genre_mat1[1,] == movie_genre2[index,col])#making data into matrix
    genre_mat1[index+1,gen_col] <- 1
  }
}
genre_mat2 <- as.data.frame(genre_mat1[-1,], stringsAsFactors=FALSE) #remove first row, which was the genre list
View(genre_mat2)
str(genre_mat2)
for (col in 1:ncol(genre_mat2)) {
  genre_mat2[,col] <- as.integer(genre_mat2[,col]) #convert from characters to integers
}
str(genre_mat2)
#a search matrix that will allow us to perform an easy search of the films by specifying the genre present in our list.
SearchMatrix <- cbind(movie_data[,1:2], genre_mat2)
head(SearchMatrix)
ratingMatrix <- dcast(ratings_data, userID, value.var = "rating", na.rm=FALSE)
View(ratingMatrix)
ratingMatrix <- as.matrix(ratingMatrix[,-1]) #remove userIds
#Convert rating matrix into a recommenderlab sparse matrix
ratingMatrix <- as(ratingMatrix, "realRatingMatrix")
ratingMatrix
recommendation_model <- recommenderRegistry$get_entries(dataType = "realRatingMatrix")
names(recommendation_model)
recommendation_model$IBCF_realRatingMatrix$parameters
#recommenderlab, we can compute similarities using various operators like cosine, pearson as well as jaccard.
similarity_mat <- similarity(ratingMatrix[1:4, ],
                             method = "cosine",
                             which = "users")
as.matrix(similarity_mat)
image(as.matrix(similarity_mat), main = "User's Similarities")
# extracting unique ratings
rating_values <- as.vector(ratingMatrix@data)
rating_values
unique(rating_values)
#making table
Table_of_Ratings <- table(rating_values) # creating a count of movie ratings
Table_of_Ratings
#most viewed movies
movie_views <- colCounts(ratingMatrix) # count views for each movie
movie_views
table_views <- data.frame(movie = names(movie_views),
                          views = movie_views) # create dataframe of views
table_views
table_views <- table_views[order(table_views$views,
                                 decreasing = TRUE), ] # sort by number of views
table_views$title <- NA
for (index in 1:10325){
  table_views[index,3] <- as.character(subset(movie_data,
                                              movie_data$movieId == table_views[index,1])$title)
}
table_views[1:6,]
#ggplot2
library(ggplot2)
ggplot(table_views[1:6, ], aes(x = title, y = views)) +
  geom_bar(stat="identity", fill = 'steelblue') +
  geom_text(aes(label=views), vjust=-0.3, size=3.5) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Total Views of the Top Films")
#Selecting useful data.
#Normalizing data.
#Binarizing the data.
#For finding useful data in our dataset, we have set the threshold for the minimum number of users who have rated a film as 50. This is also same for minimum number of views that are per film. This way, we have filtered a list of watched films from least-watched ones.
movie_ratings <-  ratin[rowCounts(ratingMatrix) > 50,
                        colCounts(ratingMatrix) > 50]
movie_ratings
sampled_data<- sample(x = c(TRUE, FALSE),
                      size = nrow(movie_ratings),
                      replace = TRUE,
                      prob = c(0.8, 0.2))
training_data <- movie_ratings[sampled_data, ]
training_data
testing_data <- movie_ratings[!sampled_data, ]
testing_data
#recommending model
recommendation_system <- recommenderRegistry$get_entries(dataType ="realRatingMatrix")
recommendation_system$IBCF_realRatingMatrix$parameters
#recommender "k is the number of item for computing similarities.
recommen_model <- Recommender(data = training_data,
                              method = "IBCF",
                              parameter = list(k = 30))
recommen_model
class(recommen_model)
model_info <- getModel(recommen_model)
class(model_info$sim)
dim(model_info$sim)
top_items <- 20
image(model_info$sim[1:top_items, 1:top_items],
      main = "Heatmap of the first rows and columns")
#recommendation
top_recommendations <- 10 # the number of items to recommend to each user
predicted_recommendations <- predict(object = recommen_model,
                                     newdata = testing_data,
                                     n = top_recommendations)
View(predicted_recommendations)
# recommendation for the first user
user1 <- predicted_recommendations@items[[1]]
movies_user1 <- predicted_recommendations@itemLabels[user3]
movies_user2 <- movies_user1
for (index in 1:10){
  movies_user2[index] <- as.character(subset(movie_data,
                                             movie_data$movieId == movies_user1[index])$title)
}
movies_user2