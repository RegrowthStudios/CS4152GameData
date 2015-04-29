#version 130

in vec3 position;
in vec3 normal;
in vec3 uv;

uniform mat4 mView;
uniform mat4 projection;
uniform mat3 mNormal;

out vec3 fragPos;
out vec3 fragNormal;
out vec3 fragUV;

void main() {
    gl_Position = projection * mView * vec4(position, 1.0);
	fragPos = (mView * vec4(position, 1.0)).xyz;
	fragNormal = normalize(mNormal * normal);
	fragUV = uv;
}