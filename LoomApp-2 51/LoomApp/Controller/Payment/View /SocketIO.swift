import Foundation
import SocketIO
 
class SocketService {
    static let shared = SocketService()
 
    private var manager: SocketManager?
    private var socket: SocketIOClient?
 
    private var isConnected = false
 
    /// Connect to the socket server
    /// - Parameters:
    ///   - accessToken: JWT auth token from login/signup
    func connect(accessToken: String, userID:String) {
        guard let url = URL(string: "https://payment-api.loomfashion.co.in") else {
            print("❌ Invalid Socket URL")
            return
        }
 
        // Setup manager with accessToken in lowercase header
        manager = SocketManager(
            socketURL: url,
            config: [
                .connectParams(["userId": userID]),          // ✅ Add user ID here
                .forceWebsockets(true)
            ]
        )
        
        socket = manager?.defaultSocket
 
        // Connected
        socket?.on(clientEvent: .connect) { [weak self] _, _ in
            print("✅ Socket connected")
            self?.isConnected = true
 
            // Optional: emit join if your backend needs it explicitly
            // self?.socket?.emit("join", "<userId>")
        }
 
        // Disconnected
        socket?.on(clientEvent: .disconnect) { [weak self] data, _ in
            print("🔌 Socket disconnected:", data.first ?? "")
            self?.isConnected = false
        }
 
        // Connection error
        socket?.on(clientEvent: .error) { data, _ in
            print("❌ Socket error:", data)
        }
 
        // Reconnect attempt
        socket?.on(clientEvent: .reconnect) { _, _ in
            print("🔁 Attempting to reconnect...")
        }
 
        // ✅ Listen for payment success
        socket?.on("payment:success") { data, _ in
            if let payload = data.first as? [String: Any] {
                print("✅ Payment Success")
                print("Order ID:", payload["orderId"] ?? "")
                print("Message:", payload["message"] ?? "")
                print("Payment ID:", payload["paymentId"] ?? "")
                // TODO: Navigate to success screen or show toast
            }
        }
 
        // ✅ Listen for payment failure
        socket?.on("payment:failed") { data, _ in
            if let payload = data.first as? [String: Any] {
                print("❌ Payment Failed")
                print("Order ID:", payload["orderId"] ?? "")
                print("Reason:", payload["reason"] ?? "")
                // TODO: Show retry screen or alert
            }
        }
 
        socket?.connect()
    }
 
    /// Disconnect the socket
    func disconnect() {
        socket?.disconnect()
        isConnected = false
        print("🔌 Socket manually disconnected")
    }
 
    /// Check if connected
    func isSocketConnected() -> Bool {
        return isConnected
    }
}
