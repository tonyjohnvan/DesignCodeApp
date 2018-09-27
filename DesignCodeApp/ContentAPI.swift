//
//  ContentAPI.swift
//  DesignCodeApp
//
//  Created by fanzhang on 9/26/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import Foundation

struct Section : Codable {
    var title : String
    var caption : String
    var body : String
    var imageName : String
    var publishDate : Date
    
    enum CodingKeys : String, CodingKey {
        case title, caption, body
        case imageName = "image"
        case publishDate = "publish_date"
    }
}

struct Bookmarks : Codable {
    var typeName : String
    var chapterNumber : String
    var sectionTitle : String
    var partHeading : String
    var content : String
    
    enum BookmarkType : String {
        case text, image, video, code
    }
    
    var type : BookmarkType?
    
    enum CodingKeys : String, CodingKey {
        case content
        case typeName = "type"
        case chapterNumber = "chapter"
        case sectionTitle = "section"
        case partHeading = "part"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        typeName = try values.decode(String.self, forKey: .typeName)
        chapterNumber = try values.decode(String.self, forKey: .chapterNumber)
        sectionTitle = try values.decode(String.self, forKey: .sectionTitle)
        partHeading = try values.decode(String.self, forKey: .partHeading)
        content = try values.decode(String.self, forKey: .content)
        
        type = BookmarkType(rawValue: typeName)
    }
}

class ContentAPI {
    static var shared : ContentAPI = ContentAPI()
    
    lazy var sections : Array<Section> = {
        guard let path = Bundle.main.path(forResource: "Section", ofType: "json") else { return [] }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else { return []}
        
        do{
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let sections = try decoder.decode(Array<Section>.self, from: data)
            return sections
        } catch{
            print(error)
        }
        return []
    }()
    
    lazy var bookmarks : Array<Bookmarks> = {
        guard let path = Bundle.main.path(forResource: "Bookmarks", ofType: "json") else { return [] }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else { return []}
        
        do{
            let decoder = JSONDecoder()
            let bookmarks = try decoder.decode(Array<Bookmarks>.self, from: data)
            return bookmarks
        } catch{
            print(error)
        }
        return []
    }()
}
