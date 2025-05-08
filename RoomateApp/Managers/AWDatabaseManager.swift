//
//  AWDatabaseManager.swift
//  RoomateApp
//
//  Created by Christopher Nastasi on 5/7/25.
//

import Foundation
import Appwrite


class AWDatabaseManager {
    static let shared = AWDatabaseManager()
    
    private let client: Client
    private let database: Databases

    private init() {
        client = Client()
            .setEndpoint("https://fra.cloud.appwrite.io/v1")
            .setProject("681aafe600208c1254d4")
            .setSelfSigned(true) // For self signed certificates, only use for development
        
        database = Databases(client)
    }
    
    func createHousehold(household: Household) async throws {
        let documentId = ID.unique()
        let collectionId = "households"
        
        let document = try JSONEncoder().encode(household)
        
        _ = try await database.createDocument(
            databaseId: "681aafe600",
            collectionId: collectionId,
            documentId: documentId,
            data: document,
            permissions: ["role:member"]
        )
    }

//    func getHousehold(household: Household) async throws -> Household {
//        let collectionId = "households"
//
//        let document = try await database.getDocument(
//            databaseId: "681aafe600",
//            collectionId: collectionId,
//            documentId: household.id.uuidString
//        )
//        
//        let householdData = try JSONDecoder().decode(Household.self, from: document.data)
//        return householdData
//    }

}

