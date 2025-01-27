//
//  Package.swift
//  telr-sdk-ios
//
//  Created by Hamdy Youssef on 27/1/2025.
//  Github: https://github.com/hamdy-youssef
//
// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "telr-sdk-ios",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "telr-sdk-ios",
            targets: ["telr-sdk-ios"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "telr-sdk-ios"),
        .testTarget(
            name: "telr-sdk-iosTests",
            dependencies: ["telr-sdk-ios"]
        ),
    ]
)
