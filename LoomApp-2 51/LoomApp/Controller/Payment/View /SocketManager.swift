//
//import Starscream
//import Foundation
//import Starscream
//
//class SocketManager: WebSocketDelegate {
//    func didReceive(event: Starscream.WebSocketEvent, client: any Starscream.WebSocketClient) {
//       // print("Starscream==\(Starscream)")
//    }
//    
//    var socket: WebSocket!
//    let userId: String
//
////    init(userId: String) {
//        self.userId = userId
//
//        var request = URLRequest(url: URL(string: "https://payment-api.loomfashion.co.in/socket")!)
//        request.timeoutInterval = 5
//        socket = WebSocket(request: request)
//        socket.delegate = self
//    }
//
//    func connect() {
//        socket.connect()
//    }
//
//    func disconnect() {
//        socket.disconnect()
//    }
//
//    // Send user ID as JSON after connection established
//    func sendUserId() {
//        let json: [String: Any] = [
//            "type": "identify",
//            "userId": userId
//        ]
//
//        if let data = try? JSONSerialization.data(withJSONObject: json, options: []),
//           let jsonString = String(data: data, encoding: .utf8) {
//            socket.write(string: jsonString)
//        }
//    }
//
//    func didReceive(event: WebSocketEvent, client: WebSocket) {
//        switch event {
//        case .connected(_):
//            print("WebSocket connected")
//            sendUserId()   // Send userId after connection
//        case .text(let string):
//            print("Received text: \(string)")
//        case .disconnected(let reason, let code):
//            print("Disconnected: \(reason) with code: \(code)")
//        case .error(let error):
//            print("Error: \(String(describing: error))")
//        default:
//            break
//        }
//    }
//}
