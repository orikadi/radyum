//
//  RestaurantSql.swift
//  radyum
//
//  Created by Studio on 19/02/2020.
//  Copyright © 2020 Studio. All rights reserved.
//


import Foundation
import SQLite
import Firebase
extension Restaurant{
    
    static func create_table(database: OpaquePointer?){
        print("creating restaurants table if it doesnt exist")
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS RESTAURANTS (RES_ID TEXT PRIMARY KEY, NAME TEXT, ADDRESS TEXT, GEOPOINT TEXT, PICTURE TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    func addToDb(){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(ModelSQL.instance.database,"INSERT OR REPLACE INTO RESTAURANTS(RES_ID, NAME, ADDRESS, GEOPOINT, PICTURE) VALUES (?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let id = self.id.cString(using: .utf8)
            let name = self.name.cString(using: .utf8)
            let address = self.address.cString(using: .utf8)
            let geoPoint = "(\(self.geoPoint!.latitude),\(self.geoPoint!.longitude))".cString(using: .utf8)
            let picture = self.picture.cString(using: .utf8)
            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 2, name,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 3, address,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 4, geoPoint,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 5, picture,-1,nil)

            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("`new restaurant` row added successfully")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    static func getAllRestaurantsFromDb()->[Restaurant]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Restaurant]()
        
        if (sqlite3_prepare_v2(ModelSQL.instance.database,"SELECT * from RESTAURANTS;",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let resId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let resName = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                let resAddress = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                let res = Restaurant(id: resId,name: resName, address: resAddress)
                let gpString = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                let separatorSet = CharacterSet(charactersIn: ",()")
                let comps = gpString.components(separatedBy: separatorSet)
                res.geoPoint = GeoPoint(latitude:Double(comps[1])! ,longitude:Double(comps[2])!)
                res.picture = String(cString:sqlite3_column_text(sqlite3_stmt,4)!)
                data.append(res)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    static func setLastUpdate(lastUpdated:Int64){
        return ModelSQL.instance.setLastUpdate(name: "RESTAURANTS", lastUpdated: lastUpdated);
    }
    
    static func getLastUpdateDate()->Int64{
        return ModelSQL.instance.getLastUpdateDate(name: "RESTAURANTS")
    }

}
