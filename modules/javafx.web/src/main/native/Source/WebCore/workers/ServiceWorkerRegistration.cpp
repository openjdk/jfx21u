/*
 * Copyright (C) 2017 Apple Inc. All rights reserved.
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

#include "config.h"
#include "ServiceWorkerRegistration.h"

#if ENABLE(SERVICE_WORKER)

namespace WebCore {

ServiceWorker* ServiceWorkerRegistration::installing()
{
    return nullptr;
}

ServiceWorker* ServiceWorkerRegistration::waiting()
{
    return nullptr;
}

ServiceWorker* ServiceWorkerRegistration::active()
{
    return nullptr;
}

const String& ServiceWorkerRegistration::scope() const
{
    return emptyString();
}

ServiceWorkerRegistration::UpdateViaCache ServiceWorkerRegistration::updateViaCache() const
{
    return UpdateViaCache::Imports;
}

void ServiceWorkerRegistration::update(Ref<DeferredPromise>&& promise)
{
    promise->reject(Exception(UnknownError, ASCIILiteral("ServiceWorkerRegistration::update not yet implemented")));
}

void ServiceWorkerRegistration::unregister(Ref<DeferredPromise>&& promise)
{
    promise->reject(Exception(UnknownError, ASCIILiteral("ServiceWorkerRegistration::unregister not yet implemented")));
}

EventTargetInterface ServiceWorkerRegistration::eventTargetInterface() const
{
    return ServiceWorkerRegistrationEventTargetInterfaceType;
}

ScriptExecutionContext* ServiceWorkerRegistration::scriptExecutionContext() const
{
    return nullptr;
}

} // namespace WebCore

#endif // ENABLE(SERVICE_WORKER)