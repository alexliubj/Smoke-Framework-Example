//  Created by Alex Liu on 2018-10-02.
//
//  Copyright © 2018 Alex Liu <alexliubo@gmail.com> All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
// Following is Amazon smoke framework Copyright
//
// Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//
// ExampleError.swift
// SmokeAPI
//

import Foundation
import SmokeOperations

enum BodyColor: String, Codable {
    case yellow = "YELLOW"
    case blue = "BLUE"
}

struct ExampleOutput: Codable, Validatable {
    let bodyColor: BodyColor
    let isGreat: Bool
    
    func validate() throws {
        if case .yellow = bodyColor {
            throw SmokeOperationsError.validationError(reason: "The body color is yellow.")
        }
    }
}

extension ExampleOutput : Equatable {
    static func ==(lhs: ExampleOutput, rhs: ExampleOutput) -> Bool {
        return lhs.bodyColor == rhs.bodyColor
            && lhs.isGreat == rhs.isGreat
    }
}
