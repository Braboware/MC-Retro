// Based on crt-easymode
// https://github.com/libretro/glsl-shaders/blob/master/crt/shaders/crt-easymode.glsl

#version 420

varying vec2 texCoord;

uniform sampler2D colortex0;

uniform float viewWidth;
uniform float viewHeight;

// crt-easymode definitions
#include "/crt_settings.glsl"

vec4 fix(vec4 c)
{
	return vec4(
        max(abs(c.x), 0.00001),
        max(abs(c.y), 0.00001),
        max(abs(c.z), 0.00001),
        max(abs(c.w), 0.00001)
    );
}

vec4 dilate(vec4 col)
{
	vec4 x = mix(vec4(1.0), col, dilation);
	return col * x;
}

vec4 tex2D(sampler2D tex, vec2 uv)
{
	return dilate(textureLod(tex, uv, 0));
}

float curve_distance(float x, float sharp)
{
	float x_step = step(0.5, x);
	float curve = 0.5 - sqrt(0.25 - (x - x_step) * (x - x_step)) * sign(0.5 - x);
	return mix(x, curve, sharp);
}

mat4 get_color_matrix(sampler2D tex, vec2 co, vec2 dx)
{
	return mat4(tex2D(tex, co - dx), tex2D(tex, co), tex2D(tex, co + dx), tex2D(tex, co + 2.0 * dx));
}

vec3 filter_lanczos(vec4 coeffs, mat4 color_matrix)
{
	vec4 col = color_matrix * coeffs;
	vec4 sample_min = min(color_matrix[1], color_matrix[2]);
	vec4 sample_max = max(color_matrix[1], color_matrix[2]);

	col = clamp(col, sample_min, sample_max);

	return col.rgb;
}

void main(){
    #ifdef crt
        float PI = 3.141592653589;

        vec2 input_size = vec2(textureSize(colortex0, 0));
        if (min(input_size.x, input_size.y) > screen_base_size)
        {
            float mult = screen_base_size / min(input_size.x, input_size.y);
            input_size *= mult;
        }
        
        vec4 source_size = vec4(input_size, vec2(1.0, 1.0) / input_size);
        vec2 screen_pixel_size = vec2( 1.0 / viewWidth, 1.0 / viewHeight );
        vec4 output_size = vec4(vec2(1.0, 1.0) / screen_pixel_size, screen_pixel_size);
        
        vec2 dx = vec2(source_size.z, 0.0);
        vec2 dy = vec2(0.0, source_size.w);
        vec2 pix_co = texCoord * source_size.xy - vec2(0.5, 0.5);
        vec2 tex_co = (floor(pix_co) + vec2(0.5, 0.5)) * source_size.zw;
        vec2 dist = fract(pix_co);
        
        float curve_x;
        vec3 col, col2;

        curve_x = curve_distance(dist.x, sharpness_h * sharpness_h);

        vec4 coeffs = PI * vec4(1.0 + curve_x, curve_x, 1.0 - curve_x, 2.0 - curve_x);

        coeffs = fix(coeffs);
        coeffs = 2.0 * sin(coeffs) * sin(coeffs * 0.5) / (coeffs * coeffs);
        coeffs /= dot(coeffs, vec4(1.0));

        col  = filter_lanczos(coeffs, get_color_matrix(colortex0, tex_co, dx));
        col2 = filter_lanczos(coeffs, get_color_matrix(colortex0, tex_co + dy, dx));
        
        col = mix(col, col2, curve_distance(dist.y, sharpness_v));
        col = pow(col, vec3(gamma_input / (dilation + 1.0)));

        float luma = dot(vec3(0.2126, 0.7152, 0.0722), col);
        float bright = (max(col.r, max(col.g, col.b)) + luma) * 0.5;
        float scan_bright = clamp(bright, scanline_bright_min, scanline_bright_max);
        float scan_beam = clamp(bright * scanline_beam_width_max, scanline_beam_width_min, scanline_beam_width_max);
        float scan_weight = 1.0 - pow(cos(texCoord.y * 2.0 * PI * source_size.y) * 0.5 + 0.5, scan_beam) * scanline_strength;
        
        float mask = 1.0 - mask_strength;
        vec2 mod_fac = floor(texCoord * output_size.xy * source_size.xy / (input_size.xy * vec2(mask_size, mask_dot_height * mask_size)));
        int dot_no = int(mod((mod_fac.x + mod(mod_fac.y, 2.0) * mask_stagger) / mask_dot_width, 3.0));
        vec3 mask_weight;

        if (dot_no == 0)
        {
            mask_weight = vec3(1.0, mask, mask);
        }
        else if (dot_no == 1)
        {
            mask_weight = vec3(mask, 1.0, mask);
        }
        else
        {
            mask_weight = vec3(mask, mask, 1.0);
        }

        if (input_size.y >= scanline_cutoff)
        {
            scan_weight = 1.0;
        }
        
        col2 = col.rgb;
        col *= vec3(scan_weight);
        col = mix(col, col2, scan_bright);
        col *= mask_weight;
        col = pow(col, vec3(1.0 / gamma_output));
        
        
        vec3 color = col * bright_boost;
    #else
        vec3 color = texture2D(colortex0, texCoord).rgb;
    #endif
    
	gl_FragColor = vec4(color, 1.0);
}