#version 300 es

// ES 3 fragment shader that handles HDR inputs and applies a LUT to convert to
// the output color space.
// Handles both samplerExternalOES(RGB) and samplerExternal2DY2YEXT(YUV) input
// samplers.

#extension GL_OES_EGL_image_external_essl3 : require
#ifdef GL_EXT_YUV_target
#extension GL_EXT_YUV_target : require
#endif

precision highp float;

#ifdef GL_EXT_YUV_target
uniform highp __samplerExternal2DY2YEXT uTexSampler;
uniform mat4 uYuvToRgbColorTransform;
#else
uniform highp samplerExternalOES uTexSampler;
#endif

uniform highp sampler3D uColorSpaceConversionLut;

in vec2 vTexSamplingCoord;
out vec4 outColor;

void main() {
  #ifdef GL_EXT_YUV_target
    vec4 ycbcr = texture(uTexSampler, vTexSamplingCoord);
    vec4 rgba =
      vec4(
        clamp(uYuvToRgbColorTransform * vec4(ycbcr.xyz, 1.0), 0.0, 1.0).rgb,
        ycbcr.a);
  #else
    vec4 rgba = texture(uTexSampler, vTexSamplingCoord);
  #endif

  outColor = vec4(texture(uColorSpaceConversionLut, rgba.xyz).xyz, rgba.w);
}
