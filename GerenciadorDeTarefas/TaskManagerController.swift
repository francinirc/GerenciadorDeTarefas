//
//  TaskManagerController.swift
//  GerenciadorDeTarefas
//
//  Created by Francini Roberta de Carvalho on 12/14/15.
//  Copyright © 2015 Francini Carvalho. All rights reserved.
//

import UIKit

class TaskManagerController: UITableViewController {
    
    private var taskList = [Task]()
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.fetchTasks()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemTaskCell", forIndexPath: indexPath)
        
        let taskItem = self.taskList[indexPath.row]
        cell.textLabel?.text = taskItem.taskDescription
        cell.detailTextLabel?.text = taskItem.local
        cell.detailTextLabel?.textColor = UIColor.grayColor()
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the database
            TaskDAO.delete(self.taskList[indexPath.row])

            // Delete the row from the list
            self.taskList.removeAtIndex(indexPath.row)
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editTask" {

            let taskEditViewController: TaskEditViewController = segue.destinationViewController as! TaskEditViewController
            taskEditViewController.task = self.taskList[(tableView.indexPathForSelectedRow?.row)!]
        } 
    }
    
    // MARK: Class methods
    
    private func fetchTasks() {
        self.taskList = TaskDAO.fetchAllTasks()
    }

}
