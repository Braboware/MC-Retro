uniform sampler2D texture;

varying vec4 color;
varying vec4 texcoord;

varying vec3 affine;

void main()
{
	gl_FragData[0] = texture2D(texture, texcoord.st) * color;
	
	gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, clamp((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale, 0.0, 1.0));
}