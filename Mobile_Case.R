cat("\014") # Clear console
rm(list = ls()) # Clear environment

#+++++++++++++++++++++++++++++++++++++++++
# Task -1: 1. Data Exploration and pre-processing
#+++++++++++++++++++++++++++++++++++++++++
install.packages("rpart.plot")

# Load required libraries from class
library(dplyr)
library(ggplot2)
library(caret)

# Set working directory
setwd("/Users/rasel/Downloads/MLBI2/Data_mobile")

# Load the dataset
data <- read.csv("/Users/rasel/Downloads/MLBI2/Data_mobile/train.csv")

# View structure and summary
str(data)
summary(data)

# Check for missing values
colSums(is.na(data))

# Check class distribution of target
table(data$price_range)
prop.table(table(data$price_range))

# Convert binary variables to factors
binary_vars <- c("blue", "dual_sim", "four_g", "three_g", "touch_screen", "wifi")
data[binary_vars] <- lapply(data[binary_vars], factor)

# Convert target variable to factor
data$price_range <- factor(data$price_range,
                           levels = c(0, 1, 2, 3),
                           labels = c("Low", "Medium", "High", "Very High"))

# Confirm changes
str(data)

# Summary Statistics and Plots
# Load ggplot2 for visualizations
library(ggplot2)

# 1. Plot class distribution of price_range
ggplot(data, aes(x = price_range, fill = price_range)) +
  geom_bar() +
  labs(title = "Distribution of Mobile Phone Price Range", x = "Price Range", y = "Count") +
  theme_minimal()

# 2. RAM vs Price Range (important numeric predictor)
ggplot(data, aes(x = price_range, y = ram, fill = price_range)) +
  geom_boxplot() +
  labs(title = "RAM by Price Range", x = "Price Range", y = "RAM (MB)") +
  theme_minimal()

# 3. Battery Power vs Price Range
ggplot(data, aes(x = price_range, y = battery_power, fill = price_range)) +
  geom_boxplot() +
  labs(title = "Battery Power by Price Range", x = "Price Range", y = "Battery Capacity (mAh)") +
  theme_minimal()

#++++++++++++++++++++++++++++++++++
#+ Task -2: Building Models (1)
#+ +++++++++++++++++++++++++++++++++

# Load required libraries
library(rpart)
library(rpart.plot)
library(caret)

# Read dataset
# Split into training (80%) and testing (20%)
set.seed(123)
train_index <- createDataPartition(data$price_range, p = 0.8, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Train decision tree model
tree_model <- rpart(price_range ~ ., data = train_data, method = "class", cp = 0.01)

# Visualize the tree
rpart.plot(tree_model, extra = 104)

# Predict on test set
tree_preds <- predict(tree_model, newdata = test_data, type = "class")

# Evaluate model
confusionMatrix(tree_preds, test_data$price_range)

# Load caret
library(caret)

#+++++++++++++++++++++++++++++++++
# Hyperparameter Tuning
#+++++++++++++++++++++++++++++++++
# Set up 5-fold cross-validation
ctrl <- trainControl(method = "cv", number = 5)

# Tune cp from 0.001 to 0.05
set.seed(123)
tuned_tree <- train(price_range ~ ., data = train_data,
                    method = "rpart",
                    trControl = ctrl,
                    tuneGrid = expand.grid(cp = seq(0.001, 0.05, 0.005)))

# View best cp
tuned_tree$bestTune
plot(tuned_tree)

# Predict on test set
tuned_preds <- predict(tuned_tree, newdata = test_data)

# Evaluate tuned model
confusionMatrix(tuned_preds, test_data$price_range)

#+++++++++++++++++++++++++++++++++++++++++
# View all training results
tuned_tree$results

# View best cp and its accuracy
tuned_tree$bestTune

# View variable importance
importance <- varImp(tuned_tree, scale = FALSE)
importance

#+++++++++++++++++++++++++++++++++++++++++
#+ Task -2: Building Models (2)
#+ +++++++++++++++++++++++++++++++++++++++++

# Load required libraries
library(e1071)
library(caret)

# Train basic SVM model
svm_model <- svm(price_range ~ ., data = train_data, kernel = "radial")

# Predict on test set
svm_preds <- predict(svm_model, newdata = test_data)

# Evaluate
confusionMatrix(svm_preds, test_data$price_range)

#+++++++++++++++++++++++++++++++++++++++++++++
#+ Check for Overfitting via Cross-Validation (SVM Tuning)
#+ +++++++++++++++++++++++++++++++++++++++++++++

set.seed(123)
svm_tuned <- train(price_range ~ ., data = train_data,
                   method = "svmRadial",
                   trControl = trainControl(method = "cv", number = 5),
                   tuneLength = 5)

# Best parameters
svm_tuned$bestTune

# Predict & evaluate
svm_tuned_preds <- predict(svm_tuned, newdata = test_data)
confusionMatrix(svm_tuned_preds, test_data$price_range)

#+++++++++++++++++++++++++++++++
#+ Model Comparison
#++++++++++++++++++++++++++++++++

# Store confusion matrices
dt_cm <- confusionMatrix(tuned_preds, test_data$price_range)
svm_cm <- confusionMatrix(svm_tuned_preds, test_data$price_range)

# Print side-by-side accuracy and kappa
dt_cm$overall["Accuracy"]
dt_cm$overall["Kappa"]

svm_cm$overall["Accuracy"]
svm_cm$overall["Kappa"]

model_compare <- data.frame(
  Model = c("Decision Tree", "SVM"),
  Accuracy = c(dt_cm$overall["Accuracy"], svm_cm$overall["Accuracy"]),
  Kappa = c(dt_cm$overall["Kappa"], svm_cm$overall["Kappa"])
)

print(model_compare)

#++++++++++++++++++++++++++++++++++++++++++
#+ Identify Important Predictors
#+ +++++++++++++++++++++++++++++++++++++++++

# Get variable importance from tuned decision tree
importance_dt <- varImp(tuned_tree)
print(importance_dt)

# Plot importance
plot(importance_dt, top = 10, main = "Top 10 Important Features (Decision Tree)")

# Get variable importance from tuned SVM
importance_svm <- varImp(svm_tuned)
print(importance_svm)

# Plot importance
plot(importance_svm, top = 10, main = "Top 10 Important Features (SVM)")

#++++++++++++++++++++++++++++++++++++++++++
#+ Apply the SVM model to the test set
#+ +++++++++++++++++++++++++++++++++++++++++

test_data_final <- read.csv("/Users/rasel/Downloads/MLBI2/Data_mobile/test.csv")

# Convert binary variables to factors in test data
binary_vars <- c("blue", "dual_sim", "four_g", "three_g", "touch_screen", "wifi")
test_data_final[binary_vars] <- lapply(test_data_final[binary_vars], factor)

# Predict on preprocessed test data
final_predictions <- predict(svm_tuned, newdata = test_data_final)

# Add predictions to the test data
test_data_final$predicted_price_range <- final_predictions

write.csv(test_data_final, "predicted_test_with_price_range1.csv", row.names = FALSE)

# Save the final model
saveRDS(svm_tuned, "svm_tuned_model.rds")

# Check the distribution of predicted price ranges
table(test_data_final$predicted_price_range)
prop.table(table(test_data_final$predicted_price_range))