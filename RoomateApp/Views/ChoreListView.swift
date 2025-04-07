//
//  ChoreListView.swift
//  RoomateApp
//
//  Created by David Abundis on 3/13/25.
//

import SwiftUI

class ChoreViewModel: ObservableObject {
    @Published var chores: [Chore] = []
    @Published var newChoreTitle = ""
    @Published var newChorePoints = 5
    
    func addChore() {
        guard !newChoreTitle.isEmpty else { return }
        let newChore = Chore(title: newChoreTitle, points: newChorePoints)
        chores.append(newChore)
        newChoreTitle = ""
    }
    
    func toggleCompletion(for choreId: UUID) {
        if let index = chores.firstIndex(where: { $0.id == choreId }) {
            var updatedChore = chores[index]
            updatedChore.toggleCompletion()
            chores[index] = updatedChore
        }
    }
    
    func removeChore(at indices: IndexSet) {
        chores.remove(atOffsets: indices)
    }
}

struct ChoreListView: View {
    @ObservedObject var viewModel = ChoreViewModel()
    @State private var points = [5, 10, 15, 20]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New task", text: $viewModel.newChoreTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        viewModel.addChore()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                }
                Form{
                    Section("Points"){
                        Picker("Points", selection: $points.first!){
                            ForEach(points, id: \.self){
                                Text(String($0))
                            }
                        }
                    }
                    
                }
                .frame(maxHeight: 100)
                .padding()
                
                List {
                    ForEach(viewModel.chores) { chore in
                        HStack {
                            Button(action: {
                                viewModel.toggleCompletion(for: chore.id)
                            }){
                                Image(systemName: chore.isCompleted ? "checkmark.circle.fill" : "circle")
                            }
                            
                            
                            Text(chore.title)
                                .strikethrough(chore.isCompleted)
                                .foregroundColor(chore.isCompleted ? .gray : .primary)
                                
                            
                            Spacer()
                            
                            Text("+\(chore.points, format: .number)pts")
                            
                            if let dueDate = chore.dueDate {
                                Text(dueDate, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .background(chore.isCompleted ? Color.green.opacity(0.4) : .clear)
                    }
                    .onDelete { indexSet in
                        viewModel.removeChore(at: indexSet)
                    }
                }
                .frame(maxHeight: 200)
            }
            .navigationTitle("Chores")
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    ChoreListView()
}
