# DesertsApp

## Description
iOS App to browse recipes using this [API](https://www.themealdb.com/api.php)

Users are shown desert recipes in alphabetical order, and when the user selects a meal, they are taken to a detail view that contains:
* meal name
* instructions
* ingredients, measures

## Application
* DesertsApp is the application main and initializes the root view `ContentVIew()`
* `ContentView` contains a `TabView` for `HomeView` and `SettingsView`
  - `HomeView` contains technical interview requirements
  - `SettingsView` for later implementation of persistence data for user preferences
* `HomeView` contains a `NavigationView` for sorted list of meals
  - Links to `DescriptionView` for meal details
* `DescriptionView` contains meal details
  
