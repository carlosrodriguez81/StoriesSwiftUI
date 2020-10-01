//
//  Story.swift
//  StoriesSwiftUI
//
//  Created by Carlos Rodriguez on 9/29/20.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

// MARK: - Story - Firebase & Local
struct Story: Identifiable, Codable {
    @DocumentID var id: String?
    let storyID: Int
    let storyTitle: String?
    let storyURL: String?
    let createdAt: Date
    let author: String
    var status: Status?

    enum CodingKeys: String, CodingKey {
        case id
        case storyID = "story_id"
        case storyTitle = "story_title"
        case storyURL = "story_url"
        case createdAt = "created_at"
        case author, status
    }
}
