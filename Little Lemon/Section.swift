//
//  Section.swift
//  Little Lemon
//
//  Created by Antonio Lopes on 28/12/23.
//

import SwiftUI

struct Section: View {
    var categories = ["Starters", "Desserts", "Drinks", "Specials"]
    var body: some View {
        ScrollView (.horizontal) {
            HStack {
                ForEach(categories) { category in
                    Text(category)
                        .fixedSize()
                }
            }
        }
    }
}

extension String: Identifiable {

    public var id: String {

        self

    }

}

#Preview {
    Section()
}
