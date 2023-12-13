//
//  TodoModel.swift
//  TodoApp
//
//  Created by Htain Lin Shwe on 07/12/2023.
//

import Foundation
import CoreData

class TodoModelView {
    
    var todo: [Todo] = []
    var context: NSManagedObjectContext;
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchAllTodo()
    }
    
    func fetchAllTodo() {
        let fetchRequest = NSFetchRequest<Todo>(entityName: "Todo")
        do {
            self.todo = try self.context.fetch(fetchRequest)
        }
        catch {
            print("\(error)")
        }
    }
    
    func editTodo(todo: Todo, name: String, done: Bool) {
        todo.name = name
        todo.done = done
        saveContext()
        
        if let index = self.todo.firstIndex(of: todo) {
            self.todo[index] = todo
        }
        
    }
    
    func addTodo(name: String) -> Todo? {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Todo", in: self.context),
              let todo = NSManagedObject(entity: entity, insertInto: self.context) as? Todo else {
            return nil
        }
        
        todo.name = name
        todo.done = false
        
        saveContext()
        
        self.todo.append(todo)
        
        return todo

    }
    
    func deleteTodo(todo: Todo) {
        self.context.delete(todo)
        saveContext()
        
        if let index = self.todo.firstIndex(of: todo) {
            self.todo.remove(at: index)
        }
    }
    
    private func saveContext() {
        do {
            try self.context.save()
        } catch {
            print("\(error)")
        }
    }
}
