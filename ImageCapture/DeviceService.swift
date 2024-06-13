import Foundation
import ImageCaptureCore
import Combine

class DeviceService: NSObject, ObservableObject {
    let browser = ICDeviceBrowser()

    var cancellables = Set<AnyCancellable>()

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
}

extension DeviceService: ICDeviceBrowserDelegate {
    func deviceBrowser(_ browser: ICDeviceBrowser, didAdd device: ICDevice, moreComing: Bool) {
        print("!@# didAdd \(device) moreComing \(moreComing)")
    }
    
    func deviceBrowser(_ browser: ICDeviceBrowser, didRemove device: ICDevice, moreGoing: Bool) {
        print("!@# didRemove \(device) moreGoing \(moreGoing)")
    }
}

import SwiftUI

extension EnvironmentValues {
    var deviceService: DeviceService {
        get { self[DeviceServiceKey.self] }
        set { self[DeviceServiceKey.self] = newValue }
    }
}

enum DeviceServiceKey: EnvironmentKey {
    static var defaultValue: DeviceService = DeviceService()
}
