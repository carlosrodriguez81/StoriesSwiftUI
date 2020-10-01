//
//  StoryRepository.swift
//  StoriesSwiftUI
//
//  Created by Carlos Rodriguez on 9/30/20.
//

import Foundation
import FirebaseFirestoreSwift

class StoryRepository: NSObject {
    
    let path = "Stories"
    let fieldFilter = "status"
    let filter = [0, 1]
    let fieldOrder = "created_at"
    
    func fetchStories(completion: @escaping (_ stories: [Story]?, _ error: Error?) -> Void) {
        db.collection(path).whereField(fieldFilter, in: filter)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(nil, err)
                } else {
                    var stories = [Story]()
                    for document in querySnapshot!.documents {
                        stories.append(try! document.data(as: Story.self)!)
                    }
                    let sortedStories = stories.sorted {
                        $0.createdAt > $1.createdAt
                    }
                    completion(sortedStories, nil)
                }
            }
    }
    func addStory(_ story: Story) {
        do {
            let _ = try db.collection(path).document("\(story.storyID)").setData(from: story)
        }
        catch {
            fatalError("Unable to encode story: \(error.localizedDescription).")
        }
    }
    func updateStory(_ story: Story, _ status: Status) {
        var storyToUpdate = story
        storyToUpdate.status = status
        if let id = storyToUpdate.id {
            do {
                try db.collection(path).document(id).setData(from: storyToUpdate)
            }
            catch {
                fatalError("Unable to encode story: \(error.localizedDescription).")
            }
        }
    }
    func mergeStories(_ storiesFromJSON: [StoryJSON], completion: @escaping (_ error: Error?) -> Void) {
        var jsonData: [StoryJSON] = storiesFromJSON
        db.collection(path).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(err)
            } else {
                for document in querySnapshot!.documents {
                    let firebaseData = try! document.data(as: Story.self)
                    for index in 0..<jsonData.count {
                        if let id = jsonData[index].storyID {
                            if let firebaseStory = firebaseData, firebaseStory.storyID == id {
                                let updateStory = Story(id: firebaseStory.id,storyID: id, storyTitle: jsonData[index].storyTitle, storyURL: jsonData[index].storyURL, createdAt: jsonData[index].createdAt, author: jsonData[index].author)
                                self.updateStory(updateStory, firebaseStory.status == .deleted ? .deleted : .updated)
                                jsonData.remove(at: index)
                                break
                            }
                        }
                    }
                }
                for story in jsonData {
                    if let id = story.storyID {
                        let newStory = Story(storyID: id, storyTitle: story.storyTitle, storyURL: story.storyURL, createdAt: story.createdAt, author: story.author, status: .new)
                        self.addStory(newStory)
                    }
                }
                completion(nil)
            }
        }
    }
}
