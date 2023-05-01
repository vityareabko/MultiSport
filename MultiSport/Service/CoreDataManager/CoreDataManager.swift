//
//  CoreDataManager.swift
//  MultiSport
//
//  Created by Витя Рябко on 29/04/23.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
   
    
    // Создаем экземпляр NSPersistentContainer и загружаем хранилище данных с именем "DB"
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DB")
        // Обрабатываем завершение загрузки хранилища данных, обрабатывая возможную ошибку
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Если произошла ошибка при загрузке, завершаем приложение с сообщением об ошибке
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        // Возвращаем созданный контейнер
        return container
    }()

    // Создаем контекст для взаимодействия с хранилищем данных
    var context: NSManagedObjectContext {
        // Получаем контекст из созданного ранее persistentContainer
        return persistentContainer.viewContext
    }

    
    // MARK: - CRUD methods
    
    // create object
    /* let newObject = CoreDataManager.shared.createObject(entity: YourEntity.self) */
    func createObject<T: NSManagedObject>(entity: T.Type) -> T {
        return NSEntityDescription.insertNewObject(forEntityName: String(describing: entity), into: context) as! T
    }
    
    // save object
    /*
     // Создание нового объекта
     let newObject = CoreDataManager.shared.createObject(entity: YourEntity.self)
     // Установка значений атрибутов
     // ...

     // Сохранение контекста после изменений
     CoreDataManager.shared.saveContext()
     */
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // update object
    /*
     // Запрос объектов
     let objects = CoreDataManager.shared.fetchObjects(entity: YourEntity.self)

     // Обновление объекта
     // Изменение атрибутов объекта
     // ...
     CoreDataManager.shared.updateObject()
     */
    func updateObject() {
        saveContext()
    }

    // delete object
    /*
     CoreDataManager.shared.deleteObject(objectToDelete)
     */
    func deleteObject(_ object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    

    /*
    Здесь моем задать какое-то predict(правила) - по которым будет совершена определения фильтрация данных,
    также задать сортировка данных. Или же можем ничего не указывать  - и получим просто все данные
     */
    
    /*
    let predicate = NSPredicate(format: "attributeName == %@", "value")
    let sortDescriptor = NSSortDescriptor(key: "attributeName", ascending: true)
    let filteredObjects = CoreDataManager.shared.fetchObjects(entity: YourEntity.self, predicate: predicate, sortDescriptors: [sortDescriptor])
     
     or
     
     get all objects
     let allObjects = CoreDataManager.shared.fetchObjects(entity: YourEntity.self)
    */
    
    func fetchObjects<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Error fetching objects: \(error)")
            return []
        }
    }

    
    // delete allObjects DB
    /*
    func deleteAllObjects() {
        let entities = persistentContainer.managedObjectModel.entities
        for entity in entities {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try context.execute(deleteRequest)
            } catch let error as NSError {
                print("Error deleting objects: \(error.localizedDescription)")
            }
        }
        saveContext()
    }
     */
    
}
