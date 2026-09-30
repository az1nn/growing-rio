shader_type spatial;
render_mode cull_disabled, diffuse_lambert_wrap, specular_disabled;

uniform sampler2D stencil_texture : source_color, filter_nearest, repeat_disable;
uniform vec4 ink_primary : source_color = vec4(0.91, 0.25, 0.53, 1.0);
uniform vec4 ink_secondary : source_color = vec4(0.21, 0.73, 0.78, 1.0);
uniform float roughness_value : hint_range(0.0, 1.0) = 0.9;
uniform float emission_strength : hint_range(0.0, 2.0) = 0.18;
uniform float alpha_cutoff : hint_range(0.0, 1.0) = 0.08;

void fragment() {
    vec4 stencil = texture(stencil_texture, UV);
    float coverage = max(stencil.a, max(stencil.r, stencil.g));
    float split = step(0.5, stencil.r - stencil.g + 0.5);
    vec3 ink = mix(ink_secondary.rgb, ink_primary.rgb, split);

    ALBEDO = ink;
    ROUGHNESS = roughness_value;
    EMISSION = ink * emission_strength * coverage;
    ALPHA = coverage >= alpha_cutoff ? coverage : 0.0;
}
