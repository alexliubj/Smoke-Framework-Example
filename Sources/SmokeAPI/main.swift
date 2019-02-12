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
import SmokeHTTP1
import SmokeOperations
import LoggerAPI

struct MyApplicationContext {}

typealias HandlerSelectorType =
    StandardSmokeHTTP1HandlerSelector<MyApplicationContext, JSONPayloadHTTP1OperationDelegate>

func handleExampleOperationAsync(input: ExampleInput, context: MyApplicationContext,
                                 responseHandler: (SmokeResult<ExampleOutput>) -> ()) throws {
    
    let attributes = ExampleOutput(bodyColor: input.theID == "123456789012" ? .blue : .yellow,
                                      isGreat: true)
    
    responseHandler(.response(attributes))
}

let allowedErrors = [(MyError.theError(reason: "MyError"), 400)]

func createHandlerSelector() -> HandlerSelectorType {
    
    var newHandlerSelector = HandlerSelectorType()
    
    newHandlerSelector.addHandlerForUri("/postexample", httpMethod: .POST,
                                        handler: OperationHandler(operation: handleExampleOperationAsync,
                                                                  allowedErrors: allowedErrors))
    
    return newHandlerSelector
}

do {
    try SmokeHTTP1Server.startAsOperationServer(
        withHandlerSelector: createHandlerSelector(),
        andContext: MyApplicationContext(),
        defaultOperationDelegate: JSONPayloadHTTP1OperationDelegate())
} catch {
    Log.error("Unable to start Operation Server: '\(error)'")
}
