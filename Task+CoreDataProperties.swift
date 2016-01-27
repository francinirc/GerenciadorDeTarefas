//
//  Task+CoreDataProperties.swift
//  GerenciadorDeTarefas
//
//  Created by Francini Roberta de Carvalho on 12/14/15.
//  Copyright © 2015 Francini Carvalho. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var local: String?
    @NSManaged var taskDescription: String?
    @NSManaged var date: NSDate?

}
