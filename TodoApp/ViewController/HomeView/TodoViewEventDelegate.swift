//
//  TodoViewEventDelegate.swift
//  TodoApp
//
//  Created by Htain Lin Shwe on 07/12/2023.
//

import Foundation
import UIKit

protocol TodoViewEventDelegate {
    func addNewTodo(name: String, viewController: UIViewController)
}
