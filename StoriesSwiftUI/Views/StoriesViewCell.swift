//
//  StoriesViewCell.swift
//  StoriesSwiftUI
//
//  Created by Carlos Rodriguez on 9/29/20.
//

import SwiftUI

struct StoriesViewCell: View {
    let story: Story
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("\(story.storyTitle ?? "")")
            Text("\(story.author) - \(story.createdAt.timeAgo())").font(.footnote)
        }
    }
}
