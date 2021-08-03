//
//  FoodAPITesting.swift
//  DietTracker
//
//  Created by Tucker(School) on 8/2/21.
//

import SwiftUI

struct FoodAPITesting: View {
    @State private var foods = [Food]()
    var body: some View {
        NavigationView {
            List(foods) { food in
                NavigationLink(
                    destination: Text(food.ENERC_KCAL)
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
    }
    
    func getFoods() {
        foods.append(Food(label: "a food", ENERC_KCAL: 1, PROCNT: 1.1, FAT: 1.2))
        foods.append(Food(label: "second food", ENERC_KCAL: 2, PROCNT: 2.1, FAT: 2.2))
        foods.append(Food(label: "third food", ENERC_KCAL: 3, PROCNT: 3.1, FAT: 3.2))
    }
}
struct FoodAPITesting_Previews: PreviewProvider {
    static var previews: some View {
        FoodAPITesting()
    }
}

struct Food: Identifiable {
    let id = UUID()
    var label: String
    var ENERC_KCAL: Int
    var PROCNT: Float
    var FAT: Float
}
