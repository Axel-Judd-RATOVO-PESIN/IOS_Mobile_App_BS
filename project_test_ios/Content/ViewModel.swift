//
//  ViewModel.swift
//  project_test_ios
//
//  Created by RATOVO PESIN Axel Judd on 03/11/2025.
//
import Observation
import Foundation

@Observable
class ViewModel {
    var counter: Int = 1 {
        didSet {
            Task { await fetchTodo(for: counter) }
        }
    }
    var todo: Todo?
    
    func fetchTodo(for id: Int) async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(id)") else {
            return
        }
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                return
            }
            
            let decoded = try JSONDecoder().decode(Todo.self, from: data)
            todo = decoded
        }catch{
            
        }
    }
}
    
