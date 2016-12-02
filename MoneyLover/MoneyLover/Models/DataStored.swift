//
//  DataStored.swift
//  MoneyLover
//
//  Created by Ngo Sy Truong on 11/23/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit
import CoreData

class DataStored: NSObject {
    
    func fetchRecordsForEntity(entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest(entityName: entity)
        var result = [NSManagedObject]()
        do {
            let records = try managedObjectContext.executeFetchRequest(fetchRequest)
            if let records = records as? [NSManagedObject] {
                result = records
            }
        } catch {
            print("Unable to fetch managed objects for entity \(entity).")
        }
        return result
    }
    
    func createRecordForEntity(entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
        var result: NSManagedObject? = nil
        let entityDescription = NSEntityDescription.entityForName(entity, inManagedObjectContext: managedObjectContext)
        if let entityDescription = entityDescription {
            result = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        }
        return result
        
    }
}
