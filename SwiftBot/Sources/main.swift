import Foundation

Task {
    do {
        var update_id = 0
        while true {
            let updates = try await getUpdates(offset: update_id)
            for update in updates {
                update_id = update.update_id + 1
                
                if let message = update.message {
                    let messageText = message.text!
                    let messageTextSplit = messageText.split(separator: " ")
                    switch messageTextSplit[0].lowercased() {
                        case "/start":
                            try await sendMessage(message: "New message", userId: message.from.id)
                        
                        case "/pasha":
                            try await sendMessage(message: "Lavrik", userId: message.from.id)
                        
                        case "/echo":
                            print(messageTextSplit)
                       
                            
                            
                        default: break
                    }
                }
            }
        }
       
    } catch {
        print("Error:", error.localizedDescription)
    }
}

RunLoop.main.run()
