import SwiftUI

struct ContentView: View {

    @ObservedObject var deviceService = DeviceService()

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Browsing: \(deviceService.browser.isBrowsing)")
                Text("Suspended: \(deviceService.browser.isSuspended)")
                Text("Auth status: `\(authStatus)`")
                Text("")
                Text("Auth response: `\(authResponse)`")
                Text("Reset response: `\(resetResponse)`")
                Text("")
                Text("Found Devices:")
                ForEach(deviceService.devices, id: \.self) { device in
                    Text(device)
                }
            }
            .font(.caption)

            Divider()

            VStack {
                Button("Authorize") {
                    deviceService.requestAuthorization()
                }.buttonStyle(.bordered)

                Button("Reset") {
                    deviceService.resetAuthorization()
                }.buttonStyle(.bordered)

                Button("Start") {
                    deviceService.start()
                }.buttonStyle(.bordered)

                Button("Stop") {
                    deviceService.stop()
                }.buttonStyle(.bordered)
            }.padding()
        }
    }

    var authStatus: String {
        deviceService.browser.contentsAuthorizationStatus.rawValue
    }

    var authResponse: String {
        deviceService.requestContentsAuthorizationResponse?.rawValue ?? "none"
    }

    var resetResponse: String {
        deviceService.resetContentsAuthorizationResponse?.rawValue ?? "none"
    }
}

#Preview {
    ContentView()
}
