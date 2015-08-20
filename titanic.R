library(rpart)
library(randomForest)
set.seed(333)

train <- read.csv('train.csv', colClasses=c("integer", "integer", "factor", "character", "factor", "numeric", "integer", "integer", "character", "numeric", "character", "factor"))

titles <- c("Mr.", "Ms.", "Mrs.", "Miss.", "Mme.", "Mlle.", "Dona.", "Rev.", "Sir.", "Don.", "Lady.", "Countess.", "Master.", "Dr.", "Col.", "Major.", "Capt.", "Jonkheer.")
regtitles <- "(Mr\\.|Ms\\.|Mrs\\.|Miss\\.|Mme\\.|Mlle\\.|Dona\\.|Rev\\.|Sir\\.|Don\\.|Lady\\.|Countess\\.|Master\\.|Dr\\.|Col\\.|Major\\.|Capt\\.|Jonkheer\\.)"
train$Title <- factor(regmatches(train$Name, regexpr(regtitles, train$Name)), titles)
train$Title[train$Title %in% c('Ms.', 'Mrs.', 'Mme.')] <- 'Ms.'
train$Title[train$Title %in% c('Miss.', 'Mlle.')] <- 'Miss.'
train$Title[train$Title %in% c('Capt.', 'Don.', 'Major.', 'Col.', 'Jonkheer.', 'Sir.')] <- 'Sir.'
train$Title[train$Title %in% c('Dona.', 'Lady.', 'Countess.')] <- 'Lady.'
train$CabinClass <- factor(substr(train$Cabin, 1, 1))

train$Embarked[c(62,830)] = "S"
train$Survived <- as.logical(train$Survived)
predicted_age <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Embarked + Title + CabinClass,
                       data=train[complete.cases(train$Age),], method="anova")
train$Age[is.na(train$Age)] <- predict(predicted_age, train[is.na(train$Age),])

forest <- randomForest(as.factor(Survived) ~ Pclass+Sex+Age+SibSp+Parch+Embarked+Title+CabinClass, data=train, importance=TRUE, ntree=1000)
