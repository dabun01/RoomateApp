//
//  ChorePoolView.swift
//  iExpense
//
//  Created by David Abundis on 3/27/25.
//

import SwiftUI


struct ChorePoolView: View {
    @State private var completedItems: [String: Bool] = [:]
    let items = ["Wash Dishes", "Sweep The Living Room", "Clean Counters", "Deep Clean Bathroom"]
    let names = ["David", "Chris", "Ruben", "You"]
    let points = [10, 20, 15, 25, 30]

       var body: some View {
           NavigationView {
               List(Array(zip(items.indices, zip(items, names))), id: \.0) { index, pair in
                   let (item, name) = pair
                   HStack {
                       VStack(alignment: .leading) {
                           Text(item)
                           Text(name)
                               .font(.subheadline)
                               .foregroundColor(.gray)
                           Text("Points: \(points[index])")
                               .font(.footnote)
                               .foregroundColor(.blue)
                       }
                       Spacer()
                       Button(action: {
                           completedItems[item] = !(completedItems[item] ?? false)
                       }) {
                           Text(completedItems[item] ?? false ? "Complete" : "Incomplete")
                               .font(.caption)
                               .padding(5)
                               .background(completedItems[item] ?? false ? Color.green : Color.red)
                               .foregroundColor(.white)
                               .cornerRadius(5)
                       }
                   }
               }
               .navigationTitle("Chore Pool")
           }
           VStack {
               Button("Add Chore") {

               }
           }
       }
}

#Preview {
    ChorePoolView()
}
