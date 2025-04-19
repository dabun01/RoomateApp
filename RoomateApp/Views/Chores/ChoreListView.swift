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
            .navigationTitle("Your Chores")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Action to add a chore
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ChoreListView()
}
//struct ChoreListView: View {
//    @ObservedObject var viewModel = ChoreViewModel()
//    @State private var points = [5, 10, 15, 20]
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                HStack {
//                    TextField("New task", text: $viewModel.newChoreTitle)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    
//                    Button(action: {
//                        viewModel.addChore()
//                    }) {
//                        Image(systemName: "plus.circle.fill")
//                            .font(.title)
//                    }
//                }
//                Form{
//                    Section("Points"){
//                        Picker("Points", selection: $points.first!){
//                            ForEach(points, id: \.self){
//                                Text(String($0))
//                            }
//                        }
//                    }
//                    
//                }
//                .frame(maxHeight: 100)
//                .padding()
//                
//                List {
//                    ForEach(viewModel.chores) { chore in
//                        HStack {
//                            Button(action: {
//                                viewModel.toggleCompletion(for: chore.id)
//                            }){
//                                Image(systemName: chore.isCompleted ? "checkmark.circle.fill" : "circle")
//                            }
//                            
//                            
//                            Text(chore.title)
//                                .strikethrough(chore.isCompleted)
//                                .foregroundColor(chore.isCompleted ? .gray : .primary)
//                                
//                            
//                            Spacer()
//                            
//                            Text("+\(chore.points, format: .number)pts")
//                            
//                            if let dueDate = chore.dueDate {
//                                Text(dueDate, style: .date)
//                                    .font(.caption)
//                                    .foregroundColor(.secondary)
//                            }
//                        }
//                        .background(chore.isCompleted ? Color.green.opacity(0.4) : .clear)
//                    }
//                    .onDelete { indexSet in
//                        viewModel.removeChore(at: indexSet)
//                    }
//                }
//                .frame(maxHeight: 200)
//            }
//            .navigationTitle("Chores")
//            .toolbar {
//                EditButton()
//            }
//        }
//    }
//}
//
//#Preview {
//    ChoreListView()
//}
