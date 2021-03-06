#version 400
out vec4 sk_FragColor;
in vec4 src;
in vec4 dst;
void main() {
    vec4 _0_blend_luminosity;
    {
        float _1_alpha = dst.w * src.w;
        vec3 _2_sda = src.xyz * dst.w;
        vec3 _3_dsa = dst.xyz * src.w;
        vec3 _4_blend_set_color_luminance;
        {
            float _5_11_blend_color_luminance;
            {
                _5_11_blend_color_luminance = dot(vec3(0.30000001192092896, 0.5899999737739563, 0.10999999940395355), _2_sda);
            }
            float _6_lum = _5_11_blend_color_luminance;

            float _7_12_blend_color_luminance;
            {
                _7_12_blend_color_luminance = dot(vec3(0.30000001192092896, 0.5899999737739563, 0.10999999940395355), _3_dsa);
            }
            vec3 _8_result = (_6_lum - _7_12_blend_color_luminance) + _3_dsa;

            float _9_minComp = min(min(_8_result.x, _8_result.y), _8_result.z);
            float _10_maxComp = max(max(_8_result.x, _8_result.y), _8_result.z);
            if (_9_minComp < 0.0 && _6_lum != _9_minComp) {
                _8_result = _6_lum + ((_8_result - _6_lum) * _6_lum) / (_6_lum - _9_minComp);
            }
            _4_blend_set_color_luminance = _10_maxComp > _1_alpha && _10_maxComp != _6_lum ? _6_lum + ((_8_result - _6_lum) * (_1_alpha - _6_lum)) / (_10_maxComp - _6_lum) : _8_result;
        }
        _0_blend_luminosity = vec4((((_4_blend_set_color_luminance + dst.xyz) - _3_dsa) + src.xyz) - _2_sda, (src.w + dst.w) - _1_alpha);

    }
    sk_FragColor = _0_blend_luminosity;

}
