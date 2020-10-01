//
//  StoriesRefreshListView.swift
//  StoriesSwiftUI
//
//  Created by Carlos Rodriguez on 9/30/20.
//

import SwiftUI

struct StoriesRefreshListView: View {
    @Binding var refreshControl: UIRefreshControl
    @Binding var stories: [Story]
    var repository = StoryRepository()
    var body: some View {
        List {
            ForEach(stories) { story in
                ZStack(alignment: .leading) {
                    StoriesViewCell(story: story)
                    NavigationLink(destination: StoryWebView(url: story.storyURL ?? "")) {
                        EmptyView()
                    }.buttonStyle(PlainButtonStyle())
                }
                .frame(height: 40)
            }.onDelete(perform: removeItem)
        }
        .listStyle(PlainListStyle())
        .onAppear {
            refreshData()
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Update"), object: nil, queue: .main) { (_) in
                // this notification is called when refresh control is called so update the data here...
                // delay of 1 second....
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.refreshData()
                }
            }
        }
    }
    //MARK: - Actions
    func removeItem(at offsets: IndexSet) {
        repository.updateStory(self.stories[offsets.first!], .deleted)
        self.stories.remove(atOffsets: offsets)
    }
    func refreshData() {
        Bundle.main.getDataJSON(url: jsonUrl) { (stories) in
            if let stories = stories {
                repository.mergeStories(stories) { (error) in
                    if error == nil {
                        fetchData()
                    }
                }
            } else {
                print("The Internet connection appears to be offline.")
                print("Unable to refresh local data from JSON.")
                fetchData()
            }
        }
    }
    func fetchData() {
        repository.fetchStories(completion: { (stories, error) in
            if let stories = stories {
                self.stories.removeAll()
                self.stories = stories
                self.refreshControl.endRefreshing()
            }
        })
    }
}

struct StoriesRefreshListView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesRefreshListView(refreshControl: .constant(.init()), stories: .constant(.init()))
    }
}
