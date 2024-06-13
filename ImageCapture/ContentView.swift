import SwiftUI

struct ContentView: View {

    @ObservedObject var deviceService = DeviceService()

    var body: some View {
        VStack {
            deviceService.browser.isBrowsing ? Text("Browsing") : Text("Not browsing")
            deviceService.browser.isSuspended ? Text("Suspended") : Text("Not suspended")

            Text("auth response: \(deviceService.requestContentsAuthorizationResponse?.rawValue ?? "none")")

            Text("reset response: \(deviceService.resetContentsAuthorizationResponse?.rawValue ?? "none")")

            Text("auth status: \(deviceService.browser.contentsAuthorizationStatus.rawValue)")

            Button("Authorize") {
                deviceService.requestAuthorization()
            }

            Button("Reset") {
                deviceService.resetAuthorization()
            }

            Button("Start") {
                deviceService.start()
            }

            Button("Stop") {
                deviceService.stop()
            }
        }
    }
}

#Preview {
    ContentView()
}
