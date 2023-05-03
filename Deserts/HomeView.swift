//
//  HomeView.swift
//  Deserts
//
//  Created by zhongyuan liu on 5/2/23.
//

import SwiftUI


struct HomeView: View {
    
    @State var sortedMeals = [String: [Meal]]()
    
    var body: some View {
        NavigationView {
            List{
//                sort meals by section(first letter)
                ForEach(sortedMeals.keys.sorted(), id: \.self){ key in
                    
//                    sort meals by alphabet and display
                    Section(header: Text(key)){
                        ForEach(sortedMeals[key]!.sorted(by: { $0.name < $1.name })) { meal in
//                            Text(meal.name)
                            NavigationLink(meal.name, destination: DescriptionView(id: meal.id))
                        }
                    }
                    
                }
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
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else{return}
        
        URLSession.shared.dataTask(with: url){data, response, error in
            guard let data = data else{return}
            
            //           decode json data to swift struct MealList
            if let decodedMeals = try? JSONDecoder().decode(MealList.self, from: data){
                DispatchQueue.main.async {
                    
                    //                    group by first letter for convenience of displaying meals by alphabet sections
                    print("in dispatch")
                    self.sortedMeals = Dictionary(grouping: decodedMeals.meals, by: {String($0.name.prefix(1)).uppercased()})
                    print(sortedMeals)
                }
            }
        }.resume()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
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
    //    let category: String
    //    let instructions: String
    let imageUrl: URL?
    
    //    CodingKeys enumeration to match property name with encoded keys
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        //        case category = "strCategory"
        //        case instructions = "strInstructions"
        case imageUrl = "strMealThumb"
    }
}

struct SectionHeader: View {
    let systemName: String
    let text: String
    
    var body: some View {
        HStack{
            Text(Image(systemName: systemName))
            Text(text)
        }.font(.title2).foregroundColor(.blue)
    }
}
