#version 300 es
// ES 3 vertex shader that applies the 4 * 4 transformation matrices
// uTransformationMatrix and the uTexTransformationMatrix.

in vec4 aFramePosition;
uniform mat4 uTransformationMatrix;
uniform mat4 uTexTransformationMatrix;
out vec2 vTexSamplingCoord;

void main() {
  gl_Position = uTransformationMatrix * aFramePosition;
  vec4 texPosition = (uTexTransformationMatrix * aFramePosition) * 0.5 + vec4(0.5);
  vTexSamplingCoord = texPosition.xy;
}
