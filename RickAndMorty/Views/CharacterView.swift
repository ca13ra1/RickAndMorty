//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by cole cabral on 2021-02-18.
//

import Foundation
import SwiftUI
import Request

struct CharacterView : View {
    let image: String
    let name: String
    let status: String
    let stats: Color
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            HStack {
                RequestImage(Url(image), animation: nil)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipped()
                    .cornerRadius(5.0)
                VStack (alignment: .leading, spacing: 5){
                    Text(name)
                    VStack {
                        Text(status)
                            .foregroundColor(Color.white)
                        }
                        .padding(.leading, 5)
                        .padding(.trailing, 5)
                        .background(stats)
                        .cornerRadius(3)
                }
            }
        }
    }
}
