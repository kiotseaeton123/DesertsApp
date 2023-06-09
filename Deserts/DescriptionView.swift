//
//  DescriptionView.swift
//  Deserts
//
//  Created by zhongyuan liu on 5/2/23.
//
/*
 MARK: DescriptionView contains meal details
 
 TODO: Update Struct Details
 currently has exhaustive CodingKeys enumeration
 */
import SwiftUI

struct DescriptionView: View {
    let id: String
    @State private var meal: Details?
    
    var body: some View {
        
        VStack{
            if let meal = meal{
                List{
                    Section{
                        Text(meal.name).foregroundColor(.orange).font(.title2)
                        Text(meal.instructions)
                    }
                    Section(header: Text("Ingredients")){
                        //                        format ingredient with corresponding measurement
                        ForEach(Array(zip(meal.ingredients, meal.measurements)), id: \.0){ (ingredient, measure) in
                            Text("\(measure) \(ingredient)")
                        }
                    }
                }
                
            }else{
                Text("hold up, loading...").onAppear{getMeal()}
            }
        }
        
    }
    
    private func getMeal(){
        //        connect with API and decode response
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else{
            return}
        
        
        URLSession.shared.dataTask(with: url){data, response, error in
            guard let data = data else{return}
            let json = String(data: data, encoding: .utf8)
            print(json!)
            
            if let decodedMeal = try? JSONDecoder().decode(DetailsList.self, from: data){
                DispatchQueue.main.async {
                    self.meal = decodedMeal.meals.first
                }
            }
            
        }.resume()
    }
}
struct DetailsList: Decodable{
    //  map API response to an array of Meal objects
    private enum CodingKeys: String, CodingKey{
        case meals
    }
    let meals: [Details]
    
}

struct Details: Decodable, Identifiable {
    let id: String
    let name: String
    let instructions: String
    let ingredients: [String]
    let measurements: [String]
    
    //    CodingKeys enumeration to match property name with encoded keys
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        //        TODO: remove enumeration of all ingredients and measures
        //        case ingredients = "strIngredient"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        
        ingredients = (1...20)
            .compactMap { try? container.decode(String.self, forKey: .init(stringValue: "strIngredient\($0)")!) }
            .filter { !$0.isEmpty }
        
        measurements = (1...20)
            .compactMap{try? container.decode(String.self, forKey: .init(stringValue: "strMeasure\($0)")!)}
            .filter { !$0.isEmpty }
        
    }
}
