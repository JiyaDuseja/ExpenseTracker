import Foundation

class GenericStore<T: Codable> {
    
    private let key: String
    private let userDefaults = UserDefaults.standard
    
    init(key: String) {
        self.key = key
    }
    
    // Save data
    func save(_ items: [T]) {
        do {
            let data = try JSONEncoder().encode(items)
            userDefaults.set(data, forKey: key)
        } catch {
            print(" Error saving data: \(error)")
        }
    }
    
    // Load data
    func load() -> [T] {
        guard let data = userDefaults.data(forKey: key) else {
            return []
        }
        
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            print(" Error loading data: \(error)")
            return []
        }
    }
    
    // Clear data (optional)
    func clear() {
        userDefaults.removeObject(forKey: key)
    }
}
