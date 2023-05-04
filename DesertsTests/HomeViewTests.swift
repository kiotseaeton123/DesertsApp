//
//  HomeViewTests.swift
//  DesertsTests
//
//  Created by zhongyuan liu on 5/3/23.
//

import XCTest
@testable import Deserts


final class HomeViewTests: XCTestCase {
    
    //    test decoding json data to Swift object (MealList), in HomeView
    func testMealListDecoding(){
        
        let json = """
        {
            "meals":[{"idMeal":"1", "strMeal":"Spanish flan"},{"idMeal":"2", "strMeal":"Strawberry cheesecake"}]
        }
        """.data(using: .utf8)!
        
        let mealList = try! JSONDecoder().decode(MealList.self, from: json)
        XCTAssert(mealList.meals.count == 2)
        XCTAssert(mealList.meals[0].name == "Spanish flan")
        XCTAssert(mealList.meals[1].id == "2" )
        
    }
    
}
