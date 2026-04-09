shader_type canvas_item;
render_mode blend_disabled;

// Controls
uniform float time_passed : hint_range(0.0, 5.0) = 0.0;     // 0 = turn 1, 5 = final turn
uniform float consequence : hint_range(0.0, 1.0) = 0.0;     // 0 = good path, 1 = bad path

// Textures (create or download small noise textures)
uniform sampler2D noise_tex : source_color, filter_nearest, repeat_enable; // small 256x256 noise
uniform sampler2D scratch_tex : source_color, filter_linear, repeat_enable; // old film scratches

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    
    // 1. Strong Sepia (warmer + older as time passes)
    float sepia_strength = 0.6 + time_passed * 0.08;
    vec3 sepia = vec3(1.2, 1.05, 0.8);
    vec3 gray = vec3(dot(color.rgb, vec3(0.299, 0.587, 0.114)));
    color.rgb = mix(color.rgb, gray * sepia, sepia_strength);
    
    // 2. Increasing Dust + Film Grain (worse with bad consequences)
    float grain = texture(noise_tex, UV * 8.0 + vec2(TIME * 20.0)).r;
    grain = (grain - 0.5) * (0.15 + consequence * 0.25 + time_passed * 0.04);
    color.rgb += grain;
    
    // 3. Scratches & Dust lines (appear more as time + bad choices)
    vec2 scratch_uv = UV * vec2(2.0, 8.0) + vec2(TIME * 0.1, TIME * 2.0);
    float scratches = texture(scratch_tex, scratch_uv).r;
    scratches = pow(scratches, 2.0) * (0.4 + consequence * 0.6 + time_passed * 0.15);
    color.rgb = mix(color.rgb, vec3(0.0), scratches * 0.25);
    
    // 4. Stronger vignette (feels more trapped/desperate)
    float vignette = 1.0 - smoothstep(0.6 - time_passed*0.05, 1.4, length(UV - 0.5));
    vignette = pow(vignette, 1.8 + consequence * 0.6);
    color.rgb *= vignette;
    
    // 5. Slight desaturation + contrast loss over time
    float desat = 0.15 + time_passed * 0.07 + consequence * 0.1;
    color.rgb = mix(color.rgb, gray, desat);
    
    COLOR = color;
}