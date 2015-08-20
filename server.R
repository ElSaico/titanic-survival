library(shiny)

source("titanic.R")

shinyServer(function(input, output) {
  output$survived <- renderText({
    survived <- predict(forest, data.frame(
      "Age"=input$Age,
      "CabinClass"=factor(input$CabinClass, levels=levels(train$CabinClass)),
      "Sex"=factor(input$Sex, levels=levels(train$Sex)),
      "Pclass"=factor(input$Pclass, levels=levels(train$Pclass)),
      "Embarked"=factor(input$Embarked, levels=levels(train$Embarked)),
      "SibSp"=input$SibSp,
      "Title"=factor(input$Title, levels=levels(train$Title)),
      "Parch"=input$Parch
      )
    )
    paste("Our most likely guess is:", if (as.logical(survived)) "Yes" else "No")
  })
})
