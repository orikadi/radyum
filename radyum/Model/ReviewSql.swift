//
//  ReviewSql.swift
//  radyum
//
//  Created by Studio on 04/03/2020.
//  Copyright © 2020 Studio. All rights reserved.
//


import Foundation
import SQLite
import Firebase
extension Review{
    
    static func create_table(database: OpaquePointer?){
        print("creating reviews table")
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS REVIEWS (REV_ID TEXT PRIMARY KEY, USER_EMAIL TEXT, USER_NAME TEXT, RESTAURANT_ID TEXT,REVIEW_TEXT TEXT, PICTURE TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }

    func addToDb(){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(ModelSQL.instance.database,"INSERT OR REPLACE INTO REVIEWS(REV_ID, USER_EMAIL, USER_NAME, RESTAURANT_ID, REVIEW_TEXT, PICTURE) VALUES (?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let id = self.id?.cString(using: .utf8)
            let userEmail = self.userEmail.cString(using: .utf8)
            let userName = self.userName.cString(using: .utf8)
            let resId = self.resId.cString(using: .utf8)
            let revText = self.text.cString(using: .utf8)
            let picture = self.picture.cString(using: .utf8)
            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 2, userEmail,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 3, userName,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 4, resId,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 5, revText,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 6, picture,-1,nil)
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new review row added successfully")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }

    static func getAllReviewsFromDb()->[Review]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Review]()
        if (sqlite3_prepare_v2(ModelSQL.instance.database,"SELECT * from REVIEWS;",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let id = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let userEmail = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                let userName = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                let resId = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                let text = String(cString:sqlite3_column_text(sqlite3_stmt,4)!)
                //make a get function that gets user from email?
                let review = Review(id: id, userEmail: userEmail, userName: userName, resId: resId, text: text)
                review.picture = String(cString:sqlite3_column_text(sqlite3_stmt,5)!)
                data.append(review)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }

    static func setLastUpdate(lastUpdated:Int64){
        return ModelSQL.instance.setLastUpdate(name: "REVIEWS", lastUpdated: lastUpdated);
    }

    static func getLastUpdateDate()->Int64{
        return ModelSQL.instance.getLastUpdateDate(name: "REVIEWS")
    }

}
