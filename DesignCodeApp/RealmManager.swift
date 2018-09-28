//
//  RealmManager.swift
//  DesignCodeApp
//
//  Created by fanzhang on 9/28/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import RealmSwift

class RealmManager {
    static var realm = try! Realm()
    
    static var bookmarks : Results<Bookmark> { return realm.objects(Bookmark.self) }
    
    static var sections : Results<Section> { return realm.objects(Section.self) }
    
    class func updateContent(){
        
        Content.load { (response : Response<Content>) in
            try! realm.write {
                realm.add(response.data.chapters, update: true)
            }
        }
        
    }
    
    class func remove (_ object : Object) {
        try! realm.write { realm.delete(object) }
    }
}
