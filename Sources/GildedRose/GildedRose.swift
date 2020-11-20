public class GildedRose {
    var items:[Item]
    
    public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        for i in 0..<items.count {
            if !items[i].isAgedBrie && !items[i].isBackstagePass {
                if (items[i].quality > 0) {
                    if !items[i].isSulfuras {
                        items[i].setQuality(by: .decreasing)
                    }
                }
            } else {
                if (items[i].quality < Item.maximumQuality) {
                    items[i].setQuality(by: .increasing)
                    
                    if items[i].isBackstagePass {
                        if (items[i].sellIn < 11) {
                            if (items[i].quality < Item.maximumQuality) {
                                items[i].setQuality(by: .increasing)
                            }
                        }
                        
                        if (items[i].sellIn < 6) {
                            if (items[i].quality < Item.maximumQuality) {
                                items[i].setQuality(by: .increasing)
                            }
                        }
                    }
                }
            }
            
            if !items[i].isSulfuras {
                items[i].sellIn = items[i].sellIn - 1
            }
            
            if (items[i].sellIn < 0) {
                if !items[i].isAgedBrie {
                    if !items[i].isBackstagePass {
                        if (items[i].quality > 0) {
                            if !items[i].isSulfuras {
                                items[i].setQuality(by: .decreasing)
                            }
                        }
                    } else {
                        items[i].setQuality(by: .zero)
                    }
                } else {
                    if (items[i].quality < Item.maximumQuality) {
                        items[i].setQuality(by: .increasing)
                    }
                }
            }
        }
    }
}
