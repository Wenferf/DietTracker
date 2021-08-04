//
//  FoodAPITesting.swift
//  DietTracker
//
//  Created by Tucker(School) on 8/2/21.
//

import SwiftUI

struct FoodAPITesting: View {
    @State private var showingAlert = false
    @State private var foods = [Food]()
    var body: some View {
        NavigationView {
            List(foods) { food in
                NavigationLink(
                    //the food.ENERC_KCAL wont work because its an int not a string
                    //but I can get around that by putting it in quotation marks
                    destination: Text("Calorie count:\(food.ENERC_KCAL)," + " Amount of fat: \(food.FAT) grams")
                        .padding(),
                    label: {
                        Text(food.label)
                    })
            }
            .navigationTitle("Programming Jokes")
        }
        .onAppear(perform: {
            getFoods()
        })
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("OK")))
        })
    }
    
    func getFoods() {
        let apiKey = "?rapidapi-key=a4d1d83323mshf9dd61f551662ebp12bf4fjsnf720612eefb1"
        let query = "https://api.edamam.com/api/food-database/parser?session=44&app_key=69d004c3e3c5b967261e625baea627fc&app_id=85b409cf&ingr=apple\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["success"] == true {
                    let contents = json["body"].arrayValue
                    for item in contents {
                        let label = item["setup"].stringValue
                        let ENERC_KCAL = item["punchline"].intValue
                        let PROCNT = item["PROCNT"].floatValue
                        let FAT = item["Fat"].floatValue
                        let food = Food(label: label, ENERC_KCAL: ENERC_KCAL, PROCNT: PROCNT, FAT: FAT)
                        foods.append(food)
                    }
                    return
                }
            }
        }
        showingAlert = true
    }
}
struct FoodAPITesting_Previews: PreviewProvider {
    static var previews: some View {
        FoodAPITesting()
    }
}

struct Food: Identifiable {
    let id = UUID()
    //these are the variables that I think we should use:
    //the name of the food
    var label: String
    //calorie count
    var ENERC_KCAL: Int
    var PROCNT: Float
    var FAT: Float
}
