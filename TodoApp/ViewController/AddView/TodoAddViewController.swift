//
//  TodoAddViewController.swift
//  TodoApp
//
//  Created by Htain Lin Shwe on 07/12/2023.
//

import UIKit

class TodoAddViewController: UIViewController {

    var delegate: TodoViewEventDelegate?
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func addData(sender: UIButton) {
        if let callback = delegate {
            callback.addNewTodo(name: textField.text ?? "",viewController: self)
        }
    }
    
    
    

    

}
