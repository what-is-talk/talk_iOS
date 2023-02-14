//
//  CoreDataStack.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/08.
//

// CoreData를 사용하기 위한 Class


import Foundation
import CoreData


class CoreDataStack{
    
    // 싱글톤 객체 생성
    static let shared = CoreDataStack()
    
    // CoreData에 Access하기 위한 NSPersistentContainer 생성
    lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores{(_, error) in
            if let error = error as NSError?{
                fatalError("Unable to load core data persistent stores: \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    // CoreData에서 데이터를 가져오고 업데이트할 수 있게 해주는 property
    var viewContext:NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    private init(){}

    
}
