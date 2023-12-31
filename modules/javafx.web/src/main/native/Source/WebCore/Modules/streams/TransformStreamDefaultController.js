/*
 * Copyright (C) 2020 Apple Inc. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY APPLE INC. AND ITS CONTRIBUTORS ``AS IS''
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL APPLE INC. OR ITS CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */

function initializeTransformStreamDefaultController()
{
    "use strict";

    if (arguments.length !== 1 && arguments[0] !== @isTransformStream)
        @throwTypeError("TransformStreamDefaultController constructor should not be called directly");

    return this;
}

@getter
function desiredSize()
{
    "use strict";

    if (!@isTransformStreamDefaultController(this))
        throw @makeThisTypeError("TransformStreamDefaultController", "enqueue");

    const stream = @getByIdDirectPrivate(this, "stream");
    const readable = @getByIdDirectPrivate(stream, "readable");
    const readableController = @getByIdDirectPrivate(readable, "readableStreamController");

    return @readableStreamDefaultControllerGetDesiredSize(readableController);
}

function enqueue()
{
    "use strict";

    if (!@isTransformStreamDefaultController(this))
        throw @makeThisTypeError("TransformStreamDefaultController", "enqueue");

    const chunk = arguments[0];
    @transformStreamDefaultControllerEnqueue(this, chunk);
}

function error()
{
    "use strict";

    if (!@isTransformStreamDefaultController(this))
        throw @makeThisTypeError("TransformStreamDefaultController", "error");

    const reason = arguments[0];
    @transformStreamDefaultControllerError(this, reason);
}

function terminate()
{
    "use strict";

    if (!@isTransformStreamDefaultController(this))
        throw @makeThisTypeError("TransformStreamDefaultController", "terminate");

    @transformStreamDefaultControllerTerminate(this);
}
