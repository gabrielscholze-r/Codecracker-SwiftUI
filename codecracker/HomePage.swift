//
//  HomePage.swift
//  codecracker
//
//  Created by Gabriel Scholze on 10/12/24.
//

import MapKit
import CoreData
import SwiftUI

struct HomePage: View {
    @Environment(\.managedObjectContext) var moc
    var language: [Language]
    var scores: [UserScores]
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(language, id: \.self) { l in
                        NavigationLink(value: l) {
                            Text(l.name ?? "Unknown Language")
                        }
                    }
                }
                .navigationDestination(for: Language.self) { language in
                    if let userScore = scores.first {
                        let initialPosition = MapCameraPosition.region(MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: language.latitude, longitude: language.longitude),
                            span: MKCoordinateSpan(latitudeDelta:3, longitudeDelta:3)
                        ))
                        LanguageTrivia(language: language, userScores: userScore, position: initialPosition)
                    } else {
                        
                        Text("No scores available")
                    }
                }
                .navigationTitle("CODECRACKER")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        
    }

    


    
}

