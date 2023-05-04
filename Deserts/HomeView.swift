//
//  HomeView.swift
//  Deserts
//
//  Created by zhongyuan liu on 5/2/23.
//
/*
 MARK: HomeView contains NavigationView for sorted list of meals
 Links to DescriptionView for details of a meal
 */
import SwiftUI


struct HomeView: View {
    
    @State var sortedMeals = [String: [Meal]]()
    
    var body: some View {
        //        navigation view for List of deserts and corresponding DescriptionView that details desert information
        NavigationView {
            List{
                //                sort meals by section(first letter)
                ForEach(sortedMeals.keys.sorted(), id: \.self){ key in
                    
                    //                    sort meals by alphabet and display
                    Section(header: Text(key)){
                        ForEach(sortedMeals[key]!.sorted(by: { $0.name < $1.name })) { meal in
                            NavigationLink(meal.name, destination: DescriptionView(id: meal.id))
                        }
                    }
                    
                }
                
                //                decoration: end list with a colorful rectangle
                ZStack{
                    Text("Bon Appetit")
                    RoundedRectangle(cornerRadius: 18.0)
                        .foregroundColor(.cyan)
                        .opacity(0.6)
                }
                
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Home")
            .onAppear{
                getMeals()
            }
        }
    }
    
    private func getMeals(){
        //        request API data and decode as Swift struct MealList
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else{return}
        
        URLSession.shared.dataTask(with: url){data, response, error in
            guard let data = data else{return}
            
            //           decode json data to swift struct MealList
            if let decodedMeals = try? JSONDecoder().decode(MealList.self, from: data){
                DispatchQueue.main.async {
                    
                    //                    group by first letter for convenience of displaying meals by alphabet sections
                    self.sortedMeals = Dictionary(grouping: decodedMeals.meals, by: {String($0.name.prefix(1)).uppercased()})
                }
            }
        }.resume()
    }
}

struct MealList: Decodable{
    //  map API response to an array of Meal objects
    private enum CodingKeys: String, CodingKey{
        case meals
    }
    let meals: [Meal]
    
    init(from decoder: Decoder) throws{
        
        //        decode container to dictionary [String:[Meal]], key is letter of alphabet, value is Meal array
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var mealsDictionary = [String: [Meal]]()
        
        for key in container.allKeys {
            if let meals = try container.decodeIfPresent([Meal].self, forKey: key) {
                mealsDictionary[key.rawValue] = meals
            }
        }
        
        meals = mealsDictionary.flatMap { $0.value }
    }
    
}

struct Meal: Decodable, Identifiable {
    let id: String
    let name: String
    //    CodingKeys enumeration to match property name with encoded keys
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
    }
}
