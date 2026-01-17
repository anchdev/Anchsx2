import SwiftUI
import Metal

@main
struct PCSX2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var isRunning = false
    @State private var selectedGame: String?
    
    var body: some View {
        ZStack {
            // Emulator display
            MetalView()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("PCSX2 iOS")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: { /* Open ROM picker */ }) {
                        Image(systemName: "folder")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                Spacer()
                
                // Control buttons
                HStack(spacing: 20) {
                    Button(action: { PCSX2Controller.shared.play() }) {
                        Image(systemName: "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    
                    Button(action: { PCSX2Controller.shared.pause() }) {
                        Image(systemName: "pause.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    
                    Button(action: { PCSX2Controller.shared.stop() }) {
                        Image(systemName: "stop.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                }
                .padding()
            }
        }
        .background(Color.black)
    }
}

struct MetalView: UIViewRepresentable {
    func makeUIView(context: Context) -> MTKView {
        let view = MTKView()
        view.device = MTLCreateSystemDefaultDevice()
        return view
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) {}
}

#Preview {
    ContentView()
}
