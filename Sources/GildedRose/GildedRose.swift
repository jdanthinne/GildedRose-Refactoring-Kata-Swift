public class GildedRose {
    var items:[Item]
    
    public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        items.forEach { item in
            if !item.isAgedBrie, !item.isBackstagePass {
                if !item.isSulfuras {
                    item.setQuality(by: .decreasing)
                }
            } else {
                item.setQuality(by: .increasing)
                
                if item.isBackstagePass {
                    if (item.sellIn < 11) {
                        item.setQuality(by: .increasing)
                    }
                    
                    if (item.sellIn < 6) {
                        item.setQuality(by: .increasing)
                    }
                }
            }
            
            if !item.isSulfuras {
                item.sellIn = item.sellIn - 1
            }
            
            if item.sellIn < 0 {
                if !item.isAgedBrie {
                    if !item.isBackstagePass {
                        if !item.isSulfuras {
                            item.setQuality(by: .decreasing)
                        }
                    } else {
                        item.setQuality(by: .zero)
                    }
                } else {
                    item.setQuality(by: .increasing)
                }
            }
        }
    }
}
