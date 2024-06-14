import Foundation
import ImageCaptureCore
import Combine

class DeviceService: NSObject, ObservableObject {
    let browser = ICDeviceBrowser()
    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        browser.delegate = self

        Timer.publish(every: 1, on: .main, in: .default)
                .autoconnect()
                .sink { [self] _ in
                    objectWillChange.send()
                }
                .store(in: &cancellables)
    }

    @Published
    var requestContentsAuthorizationResponse: ICAuthorizationStatus?

    @Published
    var resetContentsAuthorizationResponse: ICAuthorizationStatus?

    func requestAuthorization() {
        browser.requestContentsAuthorization { status in
            DispatchQueue.main.async {
                self.requestContentsAuthorizationResponse = status
            }

        }
    }

    func resetAuthorization() {
        browser.resetContentsAuthorization { status in
            DispatchQueue.main.async {
                self.resetContentsAuthorizationResponse = status
            }

        }
    }

    func start() {
        browser.start()
    }

    func stop() {
        browser.stop()
    }

    var devices: [String] {
        browser.devices?.map(\.description) ?? []
    }
}

extension DeviceService: ICDeviceBrowserDelegate {
    func deviceBrowser(_ browser: ICDeviceBrowser, didAdd device: ICDevice, moreComing: Bool) {
        objectWillChange.send()
    }
    
    func deviceBrowser(_ browser: ICDeviceBrowser, didRemove device: ICDevice, moreGoing: Bool) {
        objectWillChange.send()
    }
}
