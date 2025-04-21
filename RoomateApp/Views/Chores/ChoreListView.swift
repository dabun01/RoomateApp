//
//  ChoreListView.swift
//  RoomateApp
//
//  Created by David Abundis & Chris Nastasi on 3/13/25.
//

import SwiftUI

struct ChoreListView: View {
    @State private var completedItems: [String: Bool] = [:]
    let chores = ["Do the dishes", "Take out the trash", "Vacuum the living room", "Laundry"]
    let names = ["David", "Chris", "Ruben", "You"]
    let points = [10, 20, 15, 25]

    var body: some View {
        NavigationView {
            List(Array(zip(chores.indices, zip(chores, names)))
                .filter { $0.1.1 == "You" }, id: \.0) { index, pair in
                let (chore, name) = pair
                HStack {
                    VStack(alignment: .leading) {
                        Text(chore)
                        Text(name)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Points: \(points[index])")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Button(action: {
                        completedItems[chore] = !(completedItems[chore] ?? false)
                    }) {
                        Text(completedItems[chore] ?? false ? "Complete" : "Incomplete")
                            .font(.caption)
                            .padding(5)
                            .background(completedItems[chore] ?? false ? Color.green : Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
            }

        }
    }
}

#Preview {
    ChoreListView()
}
