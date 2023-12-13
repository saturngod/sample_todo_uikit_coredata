//
//  ViewController.swift
//  TodoApp
//
//  Created by Htain Lin Shwe on 07/12/2023.
//

import UIKit


class TodViewController: UIViewController {

    var viewModel: TodoModelView?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelgate: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        viewModel = TodoModelView(context: appDelgate.persistentContainer.viewContext)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel?.fetchAllTodo()
    }
    
    @IBAction func addNewData() {
        
        if let addViewController = storyboard?.instantiateViewController(withIdentifier: "TodoAddViewController") as? TodoAddViewController {
            
            addViewController.delegate = self
            
            
            let nav = UINavigationController(rootViewController: addViewController)
            self.navigationController?.present(nav, animated: true)
        }
        
    }


}

extension TodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.todo.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoViewCellIdeintifier") as? TodoTableViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row;
        
        cell.todo = self.viewModel?.todo[row]
        cell.updateUI()
        cell.delegate = self
        return cell
        
    }
    
    
}

extension TodViewController: TodoViewEventDelegate {
    func addNewTodo(name: String,viewController: UIViewController) {
        _ = self.viewModel?.addTodo(name: name)
        viewController.dismiss(animated: true)
        self.tableView.reloadData()
    }
    
}

extension TodViewController: TodoTableViewCellDelegate {
    
    func didClickCheckTableView(cell: TodoTableViewCell) {
        if let todo = cell.todo {
            self.viewModel?.editTodo(todo: todo, name: todo.name ?? "", done: !todo.done)
            self.tableView.reloadData()
        }
    }
    
    func didClickDeleteTableView(cell: TodoTableViewCell) {
        if let todo = cell.todo {
            self.viewModel?.deleteTodo(todo: todo)
            self.tableView.reloadData()
        }
    }
    
    
}



