#version 420

uniform sampler2D texture;
uniform sampler2D lightmap;

varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;

uniform vec4 entityColor;

varying vec3 affine;

void main()
{
    vec3 col = mix(color.rgb, entityColor.rgb, entityColor.a);
	gl_FragData[0].rgb = texture2D(texture, texcoord.st).rgb * texture2D(lightmap, lmcoord.st).rgb * col;
	
	gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, clamp((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale, 0.0, 1.0));
}