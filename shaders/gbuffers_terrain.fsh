#version 420

uniform sampler2D texture;
uniform sampler2D lightmap;

varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;

varying vec3 affine;

varying float fix;

void main()
{
    if (round(fix) == 1.)
        gl_FragData[0] = texture2D(texture, texcoord.st) * texture2D(lightmap, lmcoord.st) * color;
    else
        gl_FragData[0] = texture2D(texture, affine.xy/affine.z) * texture2D(lightmap, lmcoord.st) * color;
	
	gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, clamp((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale, 0.0, 1.0));
}