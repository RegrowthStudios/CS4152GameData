#version 130

in vec3 position;
in vec3 normal;
in vec3 uv;
in vec4 color;

uniform mat4 world;
uniform mat4 vp;
//uniform mat3 mNormal;

out vec3 fragPos;
out vec3 fragNormal;
out vec4 fragColor;
out vec3 fragUV;

void main() {
    gl_Position = vp * (world * vec4(position, 1.0));
	fragPos = (world * vec4(position, 1.0)).xyz;
	//fragNormal = normalize(mNormal * normal);
	fragNormal = normalize(normal);
	fragColor = color;
	fragUV = uv;
}