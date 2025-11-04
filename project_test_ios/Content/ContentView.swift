//
//  ContentView.swift
//  project_test_ios
//
//  Created by RATOVO PESIN Axel Judd on 03/11/2025.
//
import DesignSystem
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
            
            // 2. Initialisation d'un bouton simple
            PrimaryButton(title: "Valider", isLoading: false) {
                print("Bouton simple cliqué !")
            }.font(.headline)
            .padding(5)
            
            
            // 3. Initialisation d'un bouton avec icône
            PrimaryButton(title: "Envoyer", icon: Image(systemName: "paperplane.fill"), isLoading: false) {
                print("Bouton avec icône cliqué !")
            }
            //---- Section d'afficahe des données API
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
            
            // Boutons de modification regroupés
            HStack(spacing: 10) {
                Button("-10") { viewmodel.counter -= 10 }
                Button("-1") { viewmodel.counter -= 1 }
                Button("+1") { viewmodel.counter += 1 }
                Button("+10") { viewmodel.counter += 10 }
            }
            .buttonStyle(.borderedProminent)
            
            //  Reset
            Button("Reset", systemImage: "arrow.counterclockwise") {
                viewmodel.counter = 0
            }
            .font(.headline)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)

            
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

        
        
    }
}
    

#Preview {
    ContentView()
}
