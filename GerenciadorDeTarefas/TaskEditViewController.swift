//
//  TaskEditViewController.swift
//  GerenciadorDeTarefas
//
//  Created by Francini Roberta de Carvalho on 1/22/16.
//  Copyright © 2016 Francini Carvalho. All rights reserved.
//

import UIKit

class TaskEditViewController: UITableViewController {

    // MARK: Outlets
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    @IBOutlet weak var dateDetailDatePicker: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var localTextField: UITextField!
        
    
    // MARK: Properties
    private var datePickerHidden = true
    var task: Task? = nil
    
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.didChangeDate()
        //self.toggleDatePicker()
        
        if self.task != nil {
            self.fillFields()
        }
    }
    
    
    // MARK: IBActions
    @IBAction
    func didChangeDate() {
        dateDetailDatePicker.text = NSDateFormatter.localizedStringFromDate(taskDatePicker.date, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        if task == nil {
            self.insert()
        } else {
            self.update()
        }
    }
    
    
//    // MARK: TableView methods
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        switch (indexPath.section, indexPath.row) {
//        case (1, 1):
//            toggleDatePicker()
//        default:
//            ()
//        }
//    }
//    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if datePickerHidden && indexPath.section == 1 && indexPath.row == 0 {
//            return 0
//        } else {
//            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
//        }
//    }
    
    // MARK: Class methods
//    private func toggleDatePicker() {
//        datePickerHidden = !datePickerHidden
//        
//        // Force table to update its contents
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
    
    
    private func fillFields() {
        self.descriptionTextField.text = self.task?.taskDescription
        self.localTextField.text = self.task?.local
        self.taskDatePicker.date = (self.task?.date)!
    }
    
    private func fillTask() {
        self.task!.taskDescription = self.descriptionTextField.text
        self.task!.local = self.localTextField.text
        self.task!.date = self.taskDatePicker.date
    }
    
    private func insert() {
        
        if self.validateTask() {
            
            self.task = Task()
            self.fillTask()
            
            TaskDAO.insert(task!)
            
            self.dismissViewController()
        }
    }
    
    private func update() {
        if self.validateTask() {
            
            self.fillTask()
            
            TaskDAO.update(self.task!)
            
            self.dismissViewController()
        }
    }
    
    // Show an alert containing a message to user
    private func showAlertMessage(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // Close current view
    private func dismissViewController() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: Validation methods
    private func validateTask() -> Bool {
        if self.descriptionTextField.text == "" {
            self.showAlertMessage("Informe a descrição")
            
            return false
            
        } else if self.localTextField.text == "" {
            self.showAlertMessage("Informe o local")
            
            return false
        }
        
        return true
    }
    
    
}
