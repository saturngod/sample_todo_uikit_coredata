//
//  TodoTableViewCell.swift
//  TodoApp
//
//  Created by Htain Lin Shwe on 07/12/2023.
//

import UIKit

protocol TodoTableViewCellDelegate {
    func didClickCheckTableView(cell: TodoTableViewCell)
    func didClickDeleteTableView(cell: TodoTableViewCell)
}

class TodoTableViewCell: UITableViewCell {

    @IBOutlet var todoText: UILabel!
    @IBOutlet var button: UIButton!
    
    var delegate: TodoTableViewCellDelegate?
    
    var todo: Todo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI() {
        todoText.text = self.todo?.name ?? ""
        if let doneState = todo?.done, doneState == true {
            button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        }
        else {
            button.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickOnDone(sender: UIButton) {
        delegate?.didClickCheckTableView(cell: self)
    }
    
    @IBAction func clickOnDelete(sender: UIButton) {
        delegate?.didClickDeleteTableView(cell: self)
    }

}
