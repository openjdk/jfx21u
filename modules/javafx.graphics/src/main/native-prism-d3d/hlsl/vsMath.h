/*
 * Copyright (c) 2013, 2023, Oracle and/or its affiliates. All rights reserved.
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * This code is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 only, as
 * published by the Free Software Foundation.  Oracle designates this
 * particular file as subject to the "Classpath" exception as provided
 * by Oracle in the LICENSE file that accompanied this code.
 *
 * This code is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * version 2 for more details (a copy is included in the LICENSE file that
 * accompanied this code).
 *
 * You should have received a copy of the GNU General Public License version
 * 2 along with this work; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
 * or visit www.oracle.com if you need additional information or have any
 * questions.
 */

#include "devColor.h"
#include "vs2ps.h"
#include "vsConstants.h"

// quaternions

void quatToMatrix(float4 q, out float3 N[3]) {
    float3 t1 = q.xyz * q.yzx * 2;
    float3 t2 = q.zxy * q.www * 2;
    float3 t3 = q.xyz * q.xyz * 2;
    float3 t4 = 1 - (t3 + t3.yzx);

    float3 r1 = t1 + t2;
    float3 r2 = t1 - t2;

    N[0] = float3(t4.y, r1.x, r2.z);
    N[1] = float3(r2.x, t4.z, r1.y);
    N[2] = float3(r1.z, r2.y, t4.x);

    N[2] *= (q.w >= 0) ? 1 : -1;   // ATI normal map generator compatibility
}

//float3 getNormal(float4 q) {
//    return float3(1 - 2 * (q.y * q.y + q.z * q.z), 2 * (q.x * q.y + q.z * q.w), 2 * (q.z * q.x - q.y * q.w));
//}

float3 getLocalVector(float3 global, float3 N[3]) {
    return float3(dot(global, N[1]), dot(global, N[2]), dot(global, N[0]));
}

void transformVertexAttributes(float4 modelVertexPos, float4 modelVertexNormal, in out VsOutput vsOutput) {
    float3 worldVertexPos = mul(modelVertexPos, mWorld);

//  needed for pixel lighting
//  vsOutput.worldPos = worldVertexPos;

    vsOutput.projPos = mul(float4(worldVertexPos, 1), mViewProj);

    float3 n[3];
    quatToMatrix(modelVertexNormal, n);
    for (int i = 0; i != 3; ++i) {
        n[i] = mul(n[i], (float3x3) mWorld);
    }

//  needed for pixel lighting
//  r.worldNormals = n;

#if 0
    float3 s = pos*0.5+getTime();
    pos += float3( sin(s.y), sin(s.z), sin(s.x) )*.1;
#endif

    float3 worldVecToEye = gCameraPos.xyz - worldVertexPos;
    vsOutput.worldVecToEye = getLocalVector(worldVecToEye, n);

    for (int k = 0; k < numLights; ++k) {
        float3 worldVecToLight = gLightsPos[k].xyz - worldVertexPos;
        vsOutput.worldVecsToLights[k] = getLocalVector(worldVecToLight, n);
        float3 worldNormLightDir = gLightsNormDir[k].xyz;
        vsOutput.worldNormLightDirs[k] = getLocalVector(worldNormLightDir, n);
    }

//    vsOutput.debug = n[0];

//    vsOutput.oFog  = 1; // getFogExp2(pos);
}

//float4 retFloat(float x) { return float4(x.xxx,1); }
