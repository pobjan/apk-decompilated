#version 100
// ES 2 vertex shader that applies the 4 * 4 transformation matrices
// uTransformationMatrix and the uTexTransformationMatrix, sampling from an
// external texture.

#extension GL_OES_EGL_image_external : require
precision mediump float;
uniform samplerExternalOES uTexSampler;
varying vec2 vTexSamplingCoord;

void main() {
    gl_FragColor = texture2D(uTexSampler, vTexSamplingCoord);
}
