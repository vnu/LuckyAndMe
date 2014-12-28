//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Vinu Charanya on 12/27/14.
//  Copyright (c) 2014 vnu. All rights reserved.
//

import Foundation
import UIKit

class SlotBrain{
    
    class func unpackSlotIntoSlotRows(slots: [[Slot]]) -> [[Slot]]{
        var slotRow:[Slot] = []
        var slotRow2:[Slot] = []
        var slotRow3:[Slot] = []
        
        for slotArray in slots {
            for var index = 0; index < slotArray.count; index++ {
                let slot = slotArray[index]
                if index == 0 {
                    slotRow.append(slot)
                }
                else if index == 1 {
                    slotRow2.append(slot)
                }
                else if index == 2 {
                    slotRow3.append(slot)
                }
                else {
                    println("Error")
                }
            }
        }
        var slotInRows: [[Slot]] = [slotRow, slotRow2, slotRow3]

        return slotInRows
    }
    
    class func computeWinnings (slots: [[Slot]])->Int {
        var slotsInRows = unpackSlotIntoSlotRows(slots)
        var winnings = 0
        var flushWinCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        for slotRow in slotsInRows {
            if checkFlush(slotRow) == true {
                println("flush")
                winnings += 1
                flushWinCount += 1
            }
            if flushWinCount == 3 {
                println("Royal Flush")
                winnings += 15
            }
            if checkThreeInARow(slotRow) {
                println("three in a row")
                winnings += 1
                straightWinCount += 1
            }
            if straightWinCount == 3 {
                println("Epic straight")
                winnings += 1000
            }
            
            if checkThreeOfAKind(slotRow) {
                println("Three of a Kind")
                winnings += 3
                threeOfAKindWinCount += 1
            }
            if threeOfAKindWinCount == 3 {
                println("Threes all around")
                winnings += 50
            }
        }
        return winnings
    }
    
    class func checkFlush(slotRow: [Slot]) -> Bool {
        var isRedFlush:Bool = true
        var isBlackFlush:Bool = true
        for slot in slotRow{
            if slot.isRed{
                isRedFlush = isRedFlush && true
                isBlackFlush = false
            }
            else{
                isBlackFlush = isBlackFlush && true
                isRedFlush = false
                
            }
            if !isBlackFlush && !isRedFlush{
                break
            }

        }
        return isRedFlush || isBlackFlush
    }
    
    class func checkThreeInARow (slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        if slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2 {
            return true
        }
        else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2{
            return true
        }
        else {
            return false
        }
    }
    
    class func checkThreeOfAKind (slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        if slot1.value == slot2.value && slot1.value == slot3.value {
            return true
        }
        else {
            return false
        }
    }
    
}