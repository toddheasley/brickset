import SwiftUI

struct ContentView: View {
    
    // MARK: View
    var body: some View {
        VStack {
            Image(systemName: "batteryblock")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Brickset")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
