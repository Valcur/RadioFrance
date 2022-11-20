//
//  ShowView.swift
//  RadioFrance
//
//  Created by Loic D on 19/11/2022.
//

import SwiftUI

// Vue affichant pour une émission la liste de ses épisode
struct ShowView: View {
    let show: Show
    @Binding var showSelected: Show?
    
    var body: some View {
        ZStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showSelected = nil
                }
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }).position(x: 40, y: 40)
            
            VStack {
                Text(show.showName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 100)
                
                HStack {
                    Text("Les derniers épisodes")
                        .font(.headline)
                        .fontWeight(.thin)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("Durée")
                        .font(.headline)
                        .fontWeight(.thin)
                        .foregroundColor(.white)
                }.padding(.horizontal, 10)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(show.episodes) { episode in
                            EpisodeLineView(episode: episode)
                        }
                    }
                }

                Spacer()
            }
        }
    }
    
    //MARK: - Episode Line View
    // Ligne indiquant le nom de l'épisode ainsi que sa durée (aléatoire)
    struct EpisodeLineView: View {
        let episode: Episode
        let duration: String = "\(Int.random(in: 3...8)):\(Int.random(in: 10...59))"
        
        var body: some View {
            HStack {
                Text(episode.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(duration)
                    .font(.headline)
                    .foregroundColor(.white)
            }.frame(height: 40).padding(.horizontal, 10)
        }
    }
}
