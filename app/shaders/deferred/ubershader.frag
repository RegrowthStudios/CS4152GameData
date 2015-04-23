#version 420 core

in vec2 coord;

uniform sampler2D positionMap;
uniform sampler2D normalMap;
uniform sampler2D colorMap;
uniform sampler2D ssaoMap;

uniform vec3 l;

out vec4 fragColor;

const float specularPower = 16.0f;
const vec3 lightColor = vec3(1.0);

float linearizeDepth(float depth) {
	float f = 1000.0;
	float n = 0.1;
	return (2 * n) / (f + n - depth * (f - n));
}

void main() {
    vec3 n = normalize(texture(normalMap, coord).xyz);
	vec3 pos = texture(positionMap, coord).xyz;
	vec3 color = texture(colorMap, coord).xyz;
	float ssao = texture(ssaoMap, coord).x;

	vec3 ambient = color * 0.1;

	vec3 v = -normalize(pos);
	vec3 h = normalize(v + l);

	float ndotl = dot(n, l);
	vec3 diffuse = max(0.0f, ndotl) * color;

	vec3 specular = vec3(0);
	if (ndotl >= 0) specular = pow(max(0.0f, dot(n, h)), specularPower) * vec3(0);

	vec3 finalColor = lightColor * (diffuse + specular);

	fragColor = vec4((ambient + finalColor) * ssao, 1);
	//fragColor = vec4((ambient + finalColor), 1);
}