uniform sampler2D texture;
uniform sampler2D lightmap;

varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;

varying vec3 affine;

/*
uniform vec2 torchCoord = vec2(17./64., 22./32.);
uniform vec2 soulTorchCoord = vec2(24./64., 20./32.);
uniform vec2 redTorchCoord = vec2(6./64., 19./32.);
uniform vec2 redOffTorchCoord = vec2(7./64., 19./32.);
*/

varying float fix;

void main()
{
    if (round(fix) == 1.)
        gl_FragData[0] = texture2D(texture, texcoord.st) * texture2D(lightmap, lmcoord.st) * color;
    else
        gl_FragData[0] = texture2D(texture, affine.xy/affine.z) * texture2D(lightmap, lmcoord.st) * color;
	
	gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, clamp((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale, 0.0, 1.0));
}