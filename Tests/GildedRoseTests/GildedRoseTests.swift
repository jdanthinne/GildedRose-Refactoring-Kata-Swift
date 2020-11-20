@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {

    func testFoo() {
        let items = [Item(name: "foo", sellIn: 0, quality: 0)]
        let app = GildedRose(items: items);
        app.updateQuality();
        XCTAssertEqual("foo", app.items[0].name);
    }
    
    // MARK: - Test business logic requirments

    /// At the end of each day our system lowers both SellIn and Quality for every item.
    func testDailyBasicDecrease() {
        let items = [Item(name: "foo", sellIn: 1, quality: 1)]
        let app = GildedRose(items: items);
        app.updateQuality();
        XCTAssertEqual(0, app.items[0].sellIn);
        XCTAssertEqual(0, app.items[0].quality);
    }
    
    /// Once the sell by date has passed, Quality degrades twice as fast.
    func testSellDateQualityDrop() {
        let items = [Item(name: "foo", sellIn: 0, quality: 2)]
        let app = GildedRose(items: items);
        app.updateQuality();
        XCTAssertEqual(0, app.items[0].quality);
    }
    
    /// The Quality of an item is never negative.
    func testAlwaysPositiveQuality() {
        let items = [Item(name: "foo", sellIn: 0, quality: 0)]
        let app = GildedRose(items: items);
        app.updateQuality();
        XCTAssertEqual(0, app.items[0].quality);
    }
    
    /// "Aged Brie" actually increases in Quality the older it gets.
    func testAgedBrie() {
        let items = [Item(name: "Aged Brie", sellIn: 0, quality: 0)]
        let app = GildedRose(items: items);
        app.updateQuality();
        XCTAssertEqual(2, app.items[0].quality);
    }
    
    /// The Quality of an item is never more than the maximum quality.
    func testMaximumQuality() {
        let items = [Item(name: "Aged Brie", sellIn: 0, quality: Item.maximumQuality)]
        let app = GildedRose(items: items);
        app.updateQuality();
        XCTAssertEqual(Item.maximumQuality, app.items[0].quality);
    }
    
    /// "Sulfuras", being a legendary item, never has to be sold or decreases in Quality.
    func testSulfuras() {
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 1, quality: 1)]
        let app = GildedRose(items: items);
        app.updateQuality();
        XCTAssertEqual(1, app.items[0].sellIn);
        XCTAssertEqual(1, app.items[0].quality);
    }
    
    /// "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches:
    /// - Quality increases by 2 when there are 10 days or less
    /// - Quality increases by 3 when there are 5 days or less
    /// - Quality drops to 0 after the concert
    func testBackstagePasses() {
        let items = [
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 0),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 0),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 0)]
        let app = GildedRose(items: items);
        app.updateQuality();
        XCTAssertEqual(2, app.items[0].quality);
        XCTAssertEqual(3, app.items[1].quality);
        XCTAssertEqual(0, app.items[2].quality);
    }

    static var allTests : [(String, (GildedRoseTests) -> () throws -> Void)] {
        return [
            ("testFoo", testFoo),
            ("testDailyBasicDecrease", testDailyBasicDecrease),
            ("testSellDateQualityDrop", testSellDateQualityDrop),
            ("testAlwaysPositiveQuality", testAlwaysPositiveQuality),
            ("testAgedBrie", testAgedBrie),
            ("testMaximumQuality", testMaximumQuality),
            ("testSulfuras", testSulfuras),
            ("testBackstagePasses", testBackstagePasses),
        ]
    }
}
