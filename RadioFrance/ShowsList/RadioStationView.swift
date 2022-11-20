//
//  RadioStationView.swift
//  RadioFrance
//
//  Created by Loic D on 15/11/2022.
//

import SwiftUI

// Vue affichant pour une station la liste de ses émissions
// L'utilisateur peut cliquer sur une émission pour afficher la liste de ses épisodes
struct RadioStationView: View {
    @ObservedObject var station: RadioStation
    @State var showSelected: Show?
    @State private var backgroundGradient: Gradient = Gradient(colors: [.black, .black])
    @EnvironmentObject var radioStationListVM: RadioStationListViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(station.stationImageName)
                        .resizable()
                        .frame(width: 180, height: 180)
                        .cornerRadius(10)
                        .padding()
                        .shadow(radius: 10)
                    
                    Text(station.stationDescription)
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .italic()
                        .foregroundColor(.white)
                    
                    Spacer()
                }.padding(.top, 20)
                
                Text("Les émissions \(station.stationName)")
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .foregroundColor(.white)
                    .padding()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(0..<station.shows.count, id: \.self) { i in
                            ShowLineView(show: station.shows[i], showSelected: $showSelected)
                        }
                        if station.shows.isEmpty {
                            LoadingView()
                        }
                    }.padding(.horizontal, 5).padding(.bottom, 40)
                }
            }.scaleEffect(showSelected == nil ? 1 : 0.8).opacity(showSelected == nil ? 1 : 0)
            
            if showSelected != nil {
                ZStack {
                    ShowView(show: showSelected!, showSelected: $showSelected)
                        .opacity(showSelected == nil ? 0 : 1)
                }.transition(.move(edge: .trailing))
            }
        }.background(LinearGradient(gradient: backgroundGradient, startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea()
        .onAppear {
            setBackgroundGradient()
            radioStationListVM.loadShowsFromStation(station.stationId) { shows in
                withAnimation(.easeInOut(duration: 0.3)) {
                    //station = RadioStation(stationId: station.stationId, stationName: station.stationName, stationDescription: station.stationDescription, stationImageName: station.stationImageName, shows: shows)
                    station.shows = shows
                }
            }
        }
    }
    
    //MARK: - Show Line View
    // Ligne indiquant le nom de l'émission.
    // Cliquable pour indiquer que l'utilisateur souhaite afficher les épisodes de cette émission
    struct ShowLineView: View {
        let show: Show
        @Binding var showSelected: Show?
        
        var body: some View {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showSelected = show
                }
            }, label: {
                HStack {
                    Text(show.showName)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding(6)
                    
                    Spacer()
                }
            })
        }
    }
    
    //MARK: - Loading View
    // Cercle tournant indéfiniment
    struct LoadingView: View {
        @State var startLoadingAnim = false
        
        var body: some View {
            HStack {
                Spacer()
                Circle()
                    .trim(from: 0, to: 0.25)
                    .stroke(Color.white, lineWidth: 10)
                    .animation(Animation.linear(duration: 0))
                    .rotationEffect(Angle(degrees: startLoadingAnim ? 360 : 0))
                    .animation(startLoadingAnim ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                    .frame(width: 120, height: 120)
                Spacer()
            }.frame(height: 400)
            .onAppear {
                withAnimation {
                    startLoadingAnim.toggle()
                }
            }
        }
    }
}

extension RadioStationView {
    private func setBackgroundGradient() {
        backgroundGradient = UIImage(named: station.stationImageName)!.averageColorGradient
    }
}
