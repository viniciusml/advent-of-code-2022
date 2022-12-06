@testable import advent_of_code
import XCTest

final class DaySixTests: XCTestCase {
    
    let testInputs: [Int: String] = [
        1: "bvwbjplbgvbhsrlpgdmjqwftvncz",
        2: "nppdvjthqldpwncqszvftbrmjlhg",
        3: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
        4: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
    ]
    
    func testFirstPart() {
        let parsed = Parser.parse(.content(day: "Six"), separator: "\n")
        
        XCTAssertEqual(calculateSignal(parsed.first!, range: 4), 1804)
    }
    
    func testSecondPart() {
        let parsed = Parser.parse(.content(day: "Six"), separator: "\n")
        
        XCTAssertEqual(calculateSignal(parsed.first!, range: 14), 2508)
    }
    
    private func calculateSignal(_ string: String, range: Int) -> Int {
        var count = 0
        var temp = ""
    myloop: for character in string {
            count += 1
            
            if temp.count < range {
                temp.append(character)
            } else {
                temp = String(temp.dropFirst())
                temp.append(character)
            }
            
            if temp.count == range {
                let uniqueCharacters = Set(temp)
                if uniqueCharacters.count == range {
                    break myloop
                }
            }
        }
        
        return count
    }
}
