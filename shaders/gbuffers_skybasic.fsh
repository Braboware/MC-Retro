//Upper & lower parts of the sky


varying vec4 color;


void main()
{
	gl_FragData[0] = color;
	
	gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, clamp((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale, 0.0, 1.0));
}