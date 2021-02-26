//
//  ContentView.swift
//  RickAndMorty
//
//  Created by cole cabral on 2021-01-25.
//

import SwiftUI
import Request

struct ContentView: View {
    
    // rickandmorty api variable
    @State private var responses: [(page: Int, element: RickAndMorty)] = []
    
    var body: some View {
        NavigationView {
            List {
                // Loop over each page of results
                ForEach(self.responses, id: \.page) { response in
                    // Loop over each character. Enumerate the characters so we can identify the last one.
                    ForEach(Array(response.element.results.enumerated()), id: \.element.id) { character in
                        CharacterView(image: character.element.image ?? "", name: character.element.name ?? "", status: character.element.status.rawValue.capitalized, stats: stats[character.element.status.rawValue] ?? Color.clear)
                            .onAppear {
                                // When the last item appears, load the next results.
                                guard character.offset == response.element.results.count - 1,
                                      let next = response.element.info.next,
                                      let pageString = next.components(separatedBy: "?page=").last,
                                      let nextPage = Int(pageString)
                                else { return }
                                loadPage(nextPage)
                            }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear{ loadPage(1) }
    }
    
    /// Credits go to  Carson Katri  https://github.com/carson-katri/swift-request/issues/49
    func loadPage(_ page: Int) {
        // Don't re-fetch any data.
        guard !responses.contains(where: { $0.page == page }) else { return }
        // Get the next page of characters
        AnyRequest<RickAndMorty> {
            Url("https://rickandmortyapi.com/api/character/?page=\(page == 1 ? 1 : page)")
            Method(.get)
            Header.UserAgent(.firefoxMac)
        }
        .onObject { response in
            DispatchQueue.main.async {
                // Add the results in the correct spot if they came in late for some reason.
                responses.insert((page, response), at: page - 1)
            }
        }
        .onError {
            print("Failed with: \($0.localizedDescription)")
        }
        .call()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
