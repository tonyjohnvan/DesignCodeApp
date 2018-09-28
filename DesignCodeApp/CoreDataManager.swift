//
//  CoreDataManager.swift
//  DesignCodeApp
//
//  Created by Fan Zhang on 9/27/18.
//  Copyright © 2018 Meng To. All rights reserved.
//


import CoreData

extension NSEntityDescription{
    
    static func object<T : NSManagedObject>(into context : NSManagedObjectContext) -> T {
        return insertNewObject(forEntityName: String(describing: T.self), into: context) as! T
    }
}

extension Section {
    func configure(with codable : SectionCodable) {
        body = codable.body
        caption = codable.caption
        chapterNumber = codable.chapterNumber
        id = codable.id
        title = codable.title
        imageName = codable.imageName
        publishDate = codable.publishDate
    }
}

extension Part {
    func configure(with codable: PartCodable) {
        content = codable.content
        id = codable.id
        title = codable.title
        type = codable.typeName
    }
}

class CoreDataManager{
    
    func loadFromData() { // one time execution to load the data into your CORE_DATA (BASE)
        let contentAPI = ContentAPI.shared
        
        let bookmarksCodable = contentAPI.bookmarks
        let sectionsCodable = contentAPI.sections
        let partsCodable = contentAPI.parts
        
        // Parse them
        
        for sectionCodable in sectionsCodable {
            let section : Section = NSEntityDescription.object(into: context)
            section.configure(with: sectionCodable)
            
            let bookmarksForThisSection = bookmarksCodable.filter { $0.sectionId == section.id! }
            
            //parse the parts
            
            for partCodable in partsCodable {
                let part : Part = NSEntityDescription.object(into: context)
                part.configure(with: partCodable)
                
                section.addToParts(part)
                
                for candidate in bookmarksForThisSection{
                    if candidate.partId == part.id! {
                        let bookmark : Bookmark = NSEntityDescription.object(into: context)
                        
                        bookmark.part = part
                        bookmark.section = section
                        
                        break
                    }
                }
            }
        }
        
        saveContext()
    }
    
    func fetch <T: NSFetchRequestResult>(entityName : String, ofType coreDataType: T.Type) -> Array<T> {
        do {
            let entities = try context.fetch(NSFetchRequest<T>(entityName: entityName))
            return entities
        } catch {
            print (error)
        }
        
        return []
    }
    
    lazy var bookmarks : Array<Bookmark> = fetch(entityName: "Bookmark", ofType: Bookmark.self)
    
    lazy var sections : Array<Section> = fetch(entityName: "Section", ofType: Section.self)
    
    func remove(_ bookmark : Bookmark) {
        context.delete(bookmark)
        saveContext()
        
        bookmarks = fetch(entityName: "Bookmark", ofType: Bookmark.self)
    }
    
    static let shared = CoreDataManager()
    
    lazy var presistentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores(completionHandler: {(description, error) in
            if let error = error as? Error {
                fatalError(error.localizedDescription)
            }
        })
        
        return container
        
    }()
    
    var context : NSManagedObjectContext { return presistentContainer.viewContext }
    
    func saveContext () {
        if context.hasChanges{
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}

