//
//  ModelSQL.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import SQLite

class ModelSQL{
    static let instance = ModelSQL()
    var restaurantsDB: Connection!
    let restaurantsTable = Table("restaurants")
    let id = Expression<Int>("id") //TODO do we add the id from FireBase or do we do somthing else
    let name = Expression<String>("name")
    let address = Expression<String>("address")
    let avatar = Expression<String>("avatar")
    
    func createDB(){
        do{
            //creating DB file
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let restaurantsFileURL = documentDirectory.appendingPathComponent("restaurants").appendingPathExtension("sqlite3")
            self.restaurantsDB = try Connection(restaurantsFileURL.path)
            //creating table
            let createTable = self.restaurantsTable.create { (table) in
                table.column(self.id, primaryKey: true)
                table.column(self.name)
                table.column(self.address)
                table.column(self.avatar)
            }

            try self.restaurantsDB.run(createTable)//TODO didnt check yet need to check  if works or if id is a needed column!!
        }catch{
            //TODO handle error
            print("error creating restaurants DB")
        }
        
    }
    
    
}
