public class GildedRose {
    var items:[Item]
    
    public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        for i in 0..<items.count {
            if (items[i].name != "Aged Brie" && items[i].name != "Backstage passes to a TAFKAL80ETC concert") {
                if (items[i].quality > 0) {
                    if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                        items[i].setQuality(by: .decreasing)
                    }
                }
            } else {
                if (items[i].quality < Item.maximumQuality) {
                    items[i].setQuality(by: .increasing)
                    
                    if (items[i].name == "Backstage passes to a TAFKAL80ETC concert") {
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
            
            if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                items[i].sellIn = items[i].sellIn - 1
            }
            
            if (items[i].sellIn < 0) {
                if (items[i].name != "Aged Brie") {
                    if (items[i].name != "Backstage passes to a TAFKAL80ETC concert") {
                        if (items[i].quality > 0) {
                            if (items[i].name != "Sulfuras, Hand of Ragnaros") {
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
