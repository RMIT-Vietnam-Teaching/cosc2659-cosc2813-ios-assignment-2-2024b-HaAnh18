//
//  DragDropDelegate.swift
//  ExplodingKitten
//
//  Created by Nana on 10/8/24.
//

import SwiftUI

//struct DropViewDelegate: DropDelegate {
//    let destinationIndex: Int
//    @Binding var cards: [Card]
//    @Binding var draggedCard: Card?
//
//    func dropEntered(info: DropInfo) {
//        guard let draggedCard = draggedCard, let fromIndex = cards.firstIndex(of: draggedCard), fromIndex != destinationIndex else { return }
//
//        withAnimation {
//            cards.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: destinationIndex > fromIndex ? destinationIndex + 1 : destinationIndex)
//        }
////        
////        guard let draggedCard = draggedCard else { return  }
////        withAnimation {
////            cards.removeAll { $0 == draggedCard }
////            cards.insert(draggedCard, at: destinationIndex)
////        }
////        self.draggedCard = nil
////        return true
//    }
//
//    func performDrop(info: DropInfo) -> Bool {
//        draggedCard = nil
//        return true
//    }
//
//    func dropUpdated(info: DropInfo) -> DropProposal? {
//        return DropProposal(operation: .move)
//    }
//}


