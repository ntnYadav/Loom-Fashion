import Foundation

// MARK: - Validation Class
class BankValidation {
    
    static func validate(ifsc: String?, accountNumber: String?, confirmAccount: String?, name: String?) -> String? {
        
        // IFSC
        guard let ifsc = ifsc?.trimmingCharacters(in: .whitespacesAndNewlines), !ifsc.isEmpty else {
            return "Please enter IFSC code."
        }
        if !isValidIFSC(ifsc) {
            return "Invalid IFSC code. It should be characters in proper format."
        }

        // Account Number
        guard let accountNumber = accountNumber?.trimmingCharacters(in: .whitespacesAndNewlines), !accountNumber.isEmpty else {
            return "Please enter account number."
        }
        if accountNumber.count > 20 {
            return "Account number cannot be more than 20 digits."
        }

        // Confirm Account Number
        guard let confirmAccount = confirmAccount?.trimmingCharacters(in: .whitespacesAndNewlines), !confirmAccount.isEmpty else {
            return "Please confirm your account number."
        }
        if confirmAccount.count > 20 {
            return "Confirm account number cannot be more than 20 digits."
        }
        if accountNumber != confirmAccount {
            return "Account numbers do not match."
        }

        // Phone Number
        guard let name = name?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else {
            return "Please enter account holder name."
        }
        if !isValidName(name) {
            return "Invalid account holder name."
        }

        return nil //  All validations passed
    }

    static func isValidName(_ input: String) -> Bool {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count > 2 && trimmed.count <= 25
    }

    static func isValidIFSC(_ code: String) -> Bool {
        let pattern = "^[A-Z]{4}0[A-Z0-9]+$"
        return code.range(of: pattern, options: .regularExpression) != nil
    }
}
