//
//  VersionCheck.swift
//  LoomApp
//
//  Created by Abdul Quadir on 23/07/25.
//

import Foundation
import UIKit

class VersionCheck {

    static func checkAppUpdate(forceUpdate: Bool = false) {
        guard let bundleID = Bundle.main.bundleIdentifier else { return }
        let urlStr = "https://itunes.apple.com/lookup?bundleId=\(bundleID)"
        guard let url = URL(string: urlStr) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                  let appStoreVersion = results.first?["version"] as? String,
                  let appStoreUrl = results.first?["trackViewUrl"] as? String
                    
            else {
                print("Version check failed")
                return
            }

            let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"

            if appStoreVersion.compare(currentVersion, options: .numeric) == .orderedDescending {
                DispatchQueue.main.async {
                    showUpdateAlert(appStoreURL: appStoreUrl, force: forceUpdate)
                }
            }
        }

        task.resume()
    }

    static func showUpdateAlert(appStoreURL: String, force: Bool) {
        guard let rootVC = UIApplication.shared.windows.first?.rootViewController else { return }

        let alert = UIAlertController(title: "Update Available",
                                      message: "A new version of this app is available. Please update to continue.",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { _ in
            if let url = URL(string: appStoreURL) {
                UIApplication.shared.open(url)
            }
        }))

        // Optional dismiss button
        if !force {
            alert.addAction(UIAlertAction(title: "Not Now", style: .cancel))
        }

        rootVC.present(alert, animated: true)
    }


}
