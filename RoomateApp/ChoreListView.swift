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
    
    func addChore() {
        guard !newChoreTitle.isEmpty else { return }
        let newChore = Chore(title: newChoreTitle)
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
                            
                            if let dueDate = chore.dueDate {
                                Text(dueDate, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.removeChore(at: indexSet)
                    }
                }
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
