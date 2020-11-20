public class Item {
    public var name: String
    public var sellIn: Int
    public var quality: Int
    
    public init(name: String, sellIn: Int, quality: Int) {
        self.name = name
        self.sellIn = sellIn
        self.quality = quality
    }
}

extension Item {
    static let maximumQuality: Int = 50
    
    enum QualityOperation {
        case increasing
        case decreasing
        case zero
    }
    
    func setQuality(by operation: QualityOperation) {
        switch operation {
        case .increasing:
            quality += 1
        case .decreasing:
            quality -= 1
        case .zero:
            quality = 0
        }
    }
}

extension Item: CustomStringConvertible {
    public var description: String {
        return self.name + ", " + String(self.sellIn) + ", " + String(self.quality);
    }
}
