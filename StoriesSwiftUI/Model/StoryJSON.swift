//
//  StoryJSON.swift
//  StoriesSwiftUI
//
//  Created by Carlos Rodriguez on 9/30/20.
//

import SwiftUI

// MARK: - JSONData
struct JSONData: Codable {
    let hits: [StoryJSON]
}

// MARK: - Story JSON
struct StoryJSON: Codable {
    let storyID: Int?
    let storyTitle: String?
    let storyURL: String?
    let createdAt: Date
    let author: String
    var status: Status?

    enum CodingKeys: String, CodingKey {
        case storyID = "story_id"
        case storyTitle = "story_title"
        case storyURL = "story_url"
        case createdAt = "created_at"
        case author, status
    }
}

enum Status: Int, Codable, CaseIterable {
    case new, updated, deleted
}
