//
//  ContentAPI.swift
//  DesignCodeApp
//
//  Created by fanzhang on 9/26/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

//import Foundation
import RealmSwift

struct Content : Decodable {
    
    var chapters : Array<Chapter>
    var version : Int
    
    enum CodingKeys : String, CodingKey {
        case version
        case chapters = "content"
    }
    
}

extension Content : Resource {
    static var httpMethod: HTTPMethod { return .get }
    
    static var body: Data? { return nil}
    
    static var path : String { return "content" }
}

class Chapter : Object, Decodable{
    
    @objc dynamic var id : String = ""
    @objc dynamic var title : String = ""
    
    @objc dynamic var sections : List<Section> = List<Section>()
    
    override static func primaryKey() -> String? {return "id"}
    
    enum CodingKeys : String, CodingKey {
        case id, title, sections
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id  = try container.decode(String.self, forKey: .id )
        title  = try container.decode(String.self, forKey: .title )
        
        let sectionsArray = try container.decode(Array<Section>.self, forKey: .sections )
        
        sections = List<Section>()
        sections.append(objectsIn: sectionsArray)
    }
    
}

class Bookmark : Object, Decodable{
    @objc dynamic var section : Section?
    @objc dynamic var sectionId : String = ""
    
    @objc dynamic var part : Part?
    @objc dynamic var partId : String = ""
}

class Part : Object, Decodable {
    
    @objc dynamic var id : String = ""
    @objc dynamic var sectionId : String = ""
    @objc dynamic var order : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var subhead : String = ""
    @objc dynamic var body : String = ""
    
    @objc dynamic var image : String = ""

    var imageURL : URL? { return URL(string: image) }
    
    override static func primaryKey() -> String? {return "id"}
    
//    enum CodingKeys : String, CodingKey {
//        case id, sectionId, order, title, subhead, body, image
//    }
}

class Section : Object, Decodable {
    
    @objc dynamic var id : String = ""
    @objc dynamic var chapterId : String = ""
    @objc dynamic var order : String = ""
    @objc dynamic var slug : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var caption : String = ""
    @objc dynamic var body : String = ""
    
    @objc dynamic var image : String = ""
    
    var imageURL : URL? { return URL(string: image) }
    
    var parts : List<Part> = List<Part>()
    
    
//    var parts : List<Part>? = List<Part>()
    
    enum CodingKeys : String, CodingKey {
        case id, chapterId, order, slug, title, caption, body, image
        case parts = "contents"
    }
    override static func primaryKey() -> String? {return "id"}
    
    convenience required init(from decoder: Decoder) throws {
        
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id  = try container.decode(String.self, forKey: .id )
        title  = try container.decode(String.self, forKey: .title )
        caption  = try container.decode(String.self, forKey: .caption )
        body  = try container.decode(String.self, forKey: .body )
        chapterId  = try container.decode(String.self, forKey: .chapterId )
        slug  = try container.decode(String.self, forKey: .slug )
        image  = try container.decode(String.self, forKey: .image )
        order  = try container.decode(String.self, forKey: .order )
        
        let partsArray = try container.decode(Array<Part>.self, forKey: .parts )

        parts = List<Part>()
        parts.append(objectsIn: partsArray)
    }
}

class ContentAPI {
    static var shared : ContentAPI = ContentAPI()
    
    lazy var bookmarks : Array<Bookmark> = []
    
    static let baseURL = URL(string: "http://localhost:3000")!
    
//    func load <T: Decodable>(into swiftType : T.Type, resource: String, ofType type: String = "json") -> T? {
//        let path = Bundle.main.path(forResource: resource, ofType: type)
//        let url = URL(fileURLWithPath: path!)
//        guard let data = try? Data(contentsOf: url) else {return nil}
//
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        decoder.dateDecodingStrategy = .secondsSince1970
//
//        return try! decoder.decode(swiftType.self, from : data)
//    }

}
