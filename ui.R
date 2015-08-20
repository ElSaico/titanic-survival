library(shiny)

titles <- c("Mr.", "Ms.", "Rev.", "Sir.", "Lady.", "Master.", "Dr.")

shinyUI(fluidPage(
  titlePanel("Would You Survive at the Titanic?"),
  
  sidebarPanel(
    radioButtons("Embarked", "Port of embarkation:", c("Cherbourg"="C", "Queenstown"="Q", "Southampton"="S"), inline=TRUE),
    radioButtons("Pclass", "Passenger class:", c("1st"="1", "2nd"="2", "3rd"="3"), inline=TRUE),
    radioButtons("CabinClass", "Cabin class:", c("Unknown"="", "A"="A", "B"="B", "C"="C", "D"="D", "E"="E", "F"="F", "G"="G", "T"="T"), inline=TRUE),
    radioButtons("Title", "Title:", titles, inline=TRUE),
    radioButtons("Sex", "Sex:", c("Male"="male", "Female"="female"), inline=TRUE),
    sliderInput("Age", "Age:", min=0, max=100, value=50, post=" years"),
    numericInput("SibSp", "Number of siblings/spouses aboard:", value=0),
    numericInput("Parch", "Number of parents/children aboard:", value=0)
  ),
  
  mainPanel(
    wellPanel(
      p("Would you have survived at the ", em("RMS Titanic"), " disaster?", br(),
        "This application uses machine learning in order to guess whether you had a chance of survival, based on variables
        such as class, sex and age."),
      p("Just fill out your passenger information and a prediction will come out below. When you change a variable,
        this prediction is instantly recalculated.")
    ),
    h3(textOutput("survived"))
  )
))
