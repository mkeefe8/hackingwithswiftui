//
//  AstronautsView.swift
//  Moonshot
//
//  Created by Mary Keefe on 2/6/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions_info: [Mission]
    let astronaut_missions:[String]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    ForEach(astronaut_missions, id: \.self) { mission in
                        Text(mission)
                            .fontWeight(.medium)
                    }
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)

                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        self.missions_info = missions
        
        var missions_flown = [String]()
        for mission in missions_info {
            for crew in mission.crew {
                if crew.name == astronaut.id
                {
                    missions_flown.append( "Apollo  \(mission.id)")
                }
            }
        }
        self.astronaut_missions = missions_flown
    }
    
}



struct AstronautsView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions_info: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions_info)
    }
}
