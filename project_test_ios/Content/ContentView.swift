//
//  ContentView.swift
//  project_test_ios
//
//  Created by RATOVO PESIN Axel Judd on 03/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State var viewmodel = ViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            // Image + compteur
            Image(systemName: "globe")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.tint)
            
            Text("TODO ID : \(viewmodel.counter)")
                .font(.title2)
                .bold()
            
            // Boutons de modification regroupés
            HStack(spacing: 15) {
                Button("-10") { viewmodel.counter -= 10 }
                Button("-1") { viewmodel.counter -= 1 }
                Button("+1") { viewmodel.counter += 1 }
                Button("+10") { viewmodel.counter += 10 }
            }
            .buttonStyle(.borderedProminent)
            
            //  Reset
            Button("Reset") {
                viewmodel.counter = 0
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            
            /*
            // 🔗 Lien vers Todo
            Link("Open Todo #\(viewmodel.counter)",
                 destination: URL(string: "https://jsonplaceholder.typicode.com/todos/\(viewmodel.counter)")!)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.horizontal)
            */
            if let todo = viewmodel.todo {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Todo #\(todo.id)")
                        .font(.headline)
                        .bold()
                    
                    HStack {
                        Text("Title:")
                            .fontWeight(.semibold)
                        Text(todo.title)
                    }
                    
                    HStack {
                        Text("Completed:")
                            .fontWeight(.semibold)
                        Text(todo.completed ? "True" : "False")
                            .foregroundColor(todo.completed ? .green : .red)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            }
            
        }
        .padding()
        .task{await viewmodel.fetchTodo(for: viewmodel.counter)}
        
        
    }
}
    

#Preview {
    ContentView()
}
