//
//  ReviewRowView.swift
//  MLB
//
//  Created by Avery Merlo on 4/25/23.
//

import SwiftUI

struct ReviewRowView: View {
    
    @State var review: Review
    @State var spot: Stadium
    @State var color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(review.title)
                .font(.custom("Marker Felt", size: 18))
                .padding(.bottom, 1.0)
            HStack {
                StarsSelectionView(rating: $review.rating, interactive: false, font: .callout, fillColor: color)
                Spacer()
                Text(review.body)
                    .font(.custom("American Typewriter", size: 16))
                    .lineLimit(1)
            }
            .padding(.bottom, 1.0)
            HStack {
                Text(review.postedOn.formatted())
                    .font(.custom("American Typewriter", size: 16))
                    .lineLimit(2)
                Spacer()
                Text("By: \(review.reviewer)")
                    .font(.custom("American Typewriter", size: 16))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }
        .padding(.horizontal)
    }
}

struct ReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRowView(review: Review(title: "Nice stadium!", body: "I love how old the stadium is! Will be coming back soon.", rating: 4), spot: Stadium(name: "Fenway Park"), color: Color("Boston Red Sox - Color"))
    }
}
