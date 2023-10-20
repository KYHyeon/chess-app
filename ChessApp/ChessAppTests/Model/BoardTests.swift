//
//  BoardTests.swift
//  ChessAppTests
//
//  Created by 현기엽 on 2023/10/15.
//

import XCTest
@testable import ChessApp

final class BoardTests: XCTestCase {
    func test초기상태의_점수는_색깔별로_각각_8이다() {
        let board = Board(pieces: [Position: Piece].initialPieces)
        
        let whiteScore = board.score(for: .white)
        let blackScore = board.score(for: .black)
        
        XCTAssertEqual(whiteScore, 8)
        XCTAssertEqual(blackScore, 8)
    }
    
    func test빈_Board의_점수는_색깔별로_각각_0이다() {
        let board = Board(pieces: [:])
        
        let whiteScore = board.score(for: .white)
        let blackScore = board.score(for: .black)
        
        XCTAssertEqual(whiteScore, 0)
        XCTAssertEqual(blackScore, 0)
    }
    
    func testA6가_빈칸일때_A7에_있는_백색Pawn을_A6으로_옮길_수_있다() throws {
        var board = Board(pieces: [
            "A7": Pawn(color: .white)
        ])
        try board.move(from: "A7", to: "A6")
        XCTAssertEqual(board.pieces["A6"]?.color, .white)
        XCTAssertNil(board.pieces["A7"])
    }
    
    func testA7에_있는_백색Pawn을_2턴에_걸쳐_A5으로_옮길_수_있다() throws {
        var board = Board(pieces: [
            "A7": Pawn(color: .white)
        ])
        try board.move(from: "A7", to: "A6")
        try board.move(from: "A6", to: "A5")
        XCTAssertEqual(board.pieces["A5"]?.color, .white)
        XCTAssertNil(board.pieces["A6"])
        XCTAssertNil(board.pieces["A7"])
    }
    
    func testA6에_흑색Pawn이_있을때_A7에_있는_백색Pawn을_A6으로_옮길_수_있다() throws {
        var board = Board(pieces: [
            "A6": Pawn(color: .black),
            "A7": Pawn(color: .white)
        ])
        try board.move(from: "A7", to: "A6")
        XCTAssertEqual(board.pieces["A6"]?.color, .white)
        XCTAssertNil(board.pieces["A7"])
    }
    
    func testA6에_흑색Pawn이_있을때_A7에_있는_백색Pawn을_A6으로_옮겼다가_다시_A7로_옮길_수_없다() throws {
        var board = Board(pieces: [
            "A6": Pawn(color: .black),
            "A7": Pawn(color: .white)
        ])
        try board.move(from: "A7", to: "A6")
        do {
            try board.move(from: "A6", to: "A7")
            XCTFail()
        } catch {}
        XCTAssertEqual(board.pieces["A6"]?.color, .white)
        XCTAssertNil(board.pieces["A7"])
    }
    
    func testA6에_백색Pawn이_있을때_A7에_있는_백색Pawn을_A6으로_옮길_수_없다() throws {
        var board = Board(pieces: [
            "A6": Pawn(color: .white),
            "A7": Pawn(color: .white)
        ])
        do {
            try board.move(from: "A7", to: "A6")
            XCTFail()
        } catch {}
    }
    
    func testA7에_있는_백색Pawn을_A5으로_옮길_수_없다() throws {
        var board = Board(pieces: [
            "A7": Pawn(color: .white)
        ])
        do {
            try board.move(from: "A7", to: "A5")
            XCTFail()
        } catch {}
    }
    
    func testA7에_있는_백색Pawn을_A8으로_옮길_수_없다() throws {
        var board = Board(pieces: [
            "A7": Pawn(color: .white)
        ])
        do {
            try board.move(from: "A7", to: "A8")
            XCTFail()
        } catch {}
    }
    
    func testA7에_있는_흑색Pawn을_A6으로_옮길_수_없다() throws {
        var board = Board(pieces: [
            "A7": Pawn(color: .black)
        ])
        do {
            try board.move(from: "A7", to: "A6")
            XCTFail()
        } catch {}
    }
    
    func testA7에_말이_없을때_A6으로_옮길_수_없다() throws {
        var board = Board(pieces: [:])
        do {
            try board.move(from: "A7", to: "A6")
            XCTFail()
        } catch {}
    }
    
    func test초기상태의_board를_display할_수_있다() {
        let board = Board(pieces: [Position: Piece].initialPieces)
        let expect = """
........
♟♟♟♟♟♟♟♟
........
........
........
........
♙♙♙♙♙♙♙♙
........
"""
        XCTAssertEqual(board.display(), expect)
    }
    
    func test빈_board를_display할_수_있다() {
        let board = Board(pieces: [:])
        let expect = """
........
........
........
........
........
........
........
........
"""
        XCTAssertEqual(board.display(), expect)
    }
    
    func test흰색_Pawn_9개로_Board를_초기화_할_수_없다() {
        var board = Board()
        let result = board.updatePieces([
            "A1": Pawn(color: .white),
            "A4": Pawn(color: .white),
            "B6": Pawn(color: .white),
            "A8": Pawn(color: .white),
            "C2": Pawn(color: .white),
            "D2": Pawn(color: .white),
            "E2": Pawn(color: .white),
            "F4": Pawn(color: .white),
            "G6": Pawn(color: .white)
        ])
        XCTAssertFalse(result)
    }
}
