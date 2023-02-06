local lang_jp, lang_tc, lang_sc, dir_vt, font_extd, punc_lg

-- 初始化
if luatexja.jfont.jfm_feature
then lang_jp = luatexja.jfont.jfm_feature.jp
     lang_tc = luatexja.jfont.jfm_feature.trad
     lang_sc = luatexja.jfont.jfm_feature.smpl
     dir_vt = luatexja.jfont.jfm_feature.vert
     font_extd = luatexja.jfont.jfm_feature.extd
     punc_lg = luatexja.jfont.jfm_feature.lgp
end

-- 預處理及容錯
if font_extd and not dir_vt
then tex.error('JFM feature "extd" only works with feature "vert".' ..
               'For now I\'ll ignore it.')
     font_extd = false           
end

if punc_lg and not dir_vt
then tex.error('JFM feature "lgp" only works with feature "vert".' ..
               'For now I\'ll ignore it.')
     punc_lg = false
end

if not ((lang_jp and not (lang_tc or lang_sc))
    or  (lang_tc and not (lang_jp or lang_sc))
    or  (lang_sc and not (lang_jp or lang_tc)))
then tex.error('Specify one and only one feature from three language specific features' ..
               '"jp", "trad" or "smpl"' ..
               'is required.' ..
               'For now I\'ll use "lang_jp" for japanese by default.')
     lang_jp = true
end

-- 定義函數宏
local function logic_and(f1, f2, r1, r2)
    return f1 and (f2 and r1) or r2
end

local function logic_if(f1, r1, r2)
    return f1 and r1 or r2
end

local function context_height()
    return dir_vt and (font_extd and 0.625 or 0.5) or 0.88
end

local function context_depth()
    return dir_vt and (font_extd and 0.625 or 0.5) or 0.12
end

-- 主體
luatexja.jfont.define.jfm {
    version = 3,
    dir = logic_if(dir_vt, 'tate', 'yoko'),
    zw = 1,
    zh = logic_and(dir_vt, font_extd, 1.25, 1),
    kanjiskip = {0, 0.25, 0},
    xkanjiskip = {0.25, 0.25, 0.125},

    [0] = { -- 缺省類
        align = 'middle',
        left = 0,
        down = 0,
        width = 1,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        glue = {
            [1] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1, priority = {-1, -1}}, {}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1, priority = {0, -2}}, {}),
            [3] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1, priority = {-1, -1}}, {})),
            [6] = {},
            [7] = {},
            [8] = {},
            [9] = {}
        },
        round_threshold = 0.01
    },

    [1] = { -- 読点類
        chars = logic_and (dir_vr, punc_lg, {}, {'、', '，'}),
        align = logic_if (lang_tc, 'middle', 'left'),
        left = 0,
        down = 0,
        width = 0.5,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        glue = {
            [0] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 0, priority = {-1, -1}}, {0.5, 0, 0.5, ratio = 0, priority = {-1, 0}}),
            [1] = logic_if(lang_tc, {0.5, 0, 0.5}, {0, 0, 0.5, kanjiskip_natural = 0.5}),
            [2] = logic_if(lang_tc, {0.5, 0, 0.5}, {0, 0, 0.5, kanjiskip_natural = 0.5}),
            [3] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.25, ratio = 0}, {0.5, 0, 0.5}), logic_if(lang_tc, {0.5, 0, 0.5}, {0.5, 0, 0.5, ratio = 0})),
            [4] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 0, priority = {-1, -1}}, {0.5, 0, 0.5, ratio = 0, priority = {-1, 0}}),
            [5] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 0, priority = {0, 0}}, {0.5, 0, 0.5, ratio = 0, priority = {0, 0}}),
            [6] = {},
            [7] = {},
            [8] = {},
            [9] = {}
        },
        end_adjust = logic_if(lang_tc, {0, 0}, {0.5, 0})
    },

    [101] = { -- 読点類（行間a）
        chars = logic_and(dir_vt, punc_lg, {'、'}, {}),
        align = 'left',
        left = 0.38,
        down = -0.34,
        width = 0.0,
        height = context_height(),
        depth = context_depth(),
        italic = 0.0
    },

    [102] = { -- 読点類（行間b）
        chars = logic_and(dir_vt, punc_lg, {'，'}, {}),
        align = 'left',
        left = logic_if(lang_tc, 0.62, 0.40),
        down = logic_if(lang_tc, -0.58, -0.26),
        width = 0.0,
        height = context_height(),
        depth = context_depth(),
        italic = 0.0
    },

    [2] = { -- 句點類
        chars = logic_and(dir_vt, punc_lg, {}, {'．', '。'}),
        align = logic_if(lang_tc, 'middle', 'left'),
        left = 0,
        down = 0,
        width = 0.5,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        glue = {
            [0] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 0, priority = {-1, 0}}, {0.5, 0, 0.5, ratio = 0, priority = {-1, 1}}),
            [1] = logic_if(lang_tc, {0.5, 0, 0.5}, {0, 0, 0.5, kanjiskip_natural = 0.5}),
            [2] = logic_if(lang_tc, {0.5, 0, 0.5}, {0, 0, 0.5, kanjiskip_natural = 0.5}),
            [3] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.25, ratio = 0}, {0.5, 0, 0.5}), logic_if(lang_tc, {0.5, 0, 0.5}, {0.5, 0, 0.5, ratio = 0})),
            [4] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 0, priority = {-1, 0}}, {0.5, 0, 0.5, ratio = 0, priority = {-1, 1}}),
            [5] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 0, priority = {0, 0}}, {0.5, 0, 0.5, ratio = 0, priority = {0, 0}}),
            [6] = {},
            [7] = {},
            [8] = {},
            [9] = {}
        },
        end_adjust = logic_if(lang_tc, {0, 0}, {0.5, 0})
    },

    [201] = { -- 句點類（行間a）
        chars = logic_and(dir_vt, punc_lg, {'．'}, {}),
        align = 'left',
        left = logic_if(lang_tc, 0.68, 0.34),
        down = logic_if(lang_tc, -0.58, -0.28),
        width = 0.0,
        height = context_height(),
        depth = context_height(),
        italic = 0.0
    },

    [202] = { -- 句點類（行間b）
        chars = logic_and(dir_vt, punc_lg, {'。'}, {}),
        align = 'left',
        left = 0.42,
        down = -0.35,
        width = 0.0,
        height = context_height(),
        depth = context_height(),
        italic = 0.0
    },

    [3] = { -- 兩點類
        chars = logic_if(lang_jp, {}, (logic_and(dir_vt, punc_lg, {}, {'：', '；'}))),
        align = logic_if(lang_tc, 'middle', 'left'),
        left = 0,
        down = 0,
        width = logic_if(dir_vt, 1, 0.5),
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        glue = {
            [0] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.25, ratio = 0, priority = {-1, -1}}, {0.5, 0, 0.5, ratio = 0, priority = {-1, -2}})),
            [1] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1, priority = {0, 0}}, {}), logic_if(lang_tc, {0.5, 0, 0.5}, {0.5, 0, 0.5, ratio = 0})),
            [2] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1, priority = {0, 0}}, {}), logic_if(lang_tc, {0.5, 0, 0.5}, {0.5, 0, 0.5, ratio = 0})),
            [3] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.5, 0, 0.5}, {0.5, 0, 0.5, ratio = 0})),
            [4] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.25, ratio = 0}, {0.5, 0, 0.5, ratio = 0})),
            [5] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.25, ratio = 0}, {0.5, 0, 0.5, ratio = 0})),
            [6] = {},
            [7] = {},
            [8] = {},
            [9] = {}
        }
    },

    [301] = { -- 兩點類（行間a）
        chars = logic_if(lang_jp, {}, logic_and(dir_vt, punc_lg, {'：'}, {})),
        align = 'left',
        left = logic_if(lang_tc, 0.94, 0.72),
        down = logic_if(lang_tc, -0.58, -0.34),
        width = 0.0,
        height = context_height(),
        depth = context_depth(),
        italic = 0.0
    },

    [302] = { -- 兩點類（行間b）
        chars = logic_if(lang_jp, {}, logic_and(dir_vt, punc_lg, {'；'}, {})),
        align = 'left',
        left = logic_if(lang_tc, 0.96, 0.78),
        down = logic_if(lang_tc, -0.58, -0.34),
        width = 0.0,
        height = context_height(),
        depth = context_depth(),
        italic = 0.0
    },

    [4] = { -- 小書きの仮名類
        chars = {
            'ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ', 'っ', 'ゃ', 'ゅ', 'ょ', 'ゎ', 'ゕ',
            'ゖ', 'ゝ', 'ゞ', 'ァ', 'ィ', 'ゥ', 'ェ', 'ォ', 'ッ', 'ャ', 'ュ',
            'ョ', 'ヮ', 'ヵ', 'ヶ', 'ヽ', 'ヾ', 'ㇰ', 'ㇱ', 'ㇲ', 'ㇳ', 'ㇴ',
            'ㇵ', 'ㇶ', 'ㇷ', 'ㇸ', 'ㇹ', 'ㇺ', 'ㇻ', 'ㇼ', 'ㇽ', 'ㇾ', 'ㇿ',
        },
        align = 'middle',
        left = 0,
        down = 0,
        width = 1,
        height = context_height(),
        depth = context_depth(),
        glue = {
            [1] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1, priority = {-1, -1}}, {}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1, priority = {-1, 0}}, {}),
            [3] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1, priority = {-1, -1}}, {}),
            [6] = {},
            [7] = {},
            [8] = {},
            [9] = {}
        }
    },

    [5] = { -- 疑問感嘆類
        chars = {'！', '？', '‼︎', '⁉︎', '⁈', '⁇'},
        align = 'middle',
        left = 0,
        down = 0,
        width = 1,
        height = context_height(),
        depth = context_depth(),
        glue = {
            [0] = logic_if(lang_jp, logic_if(dir_vt, {1, 0, 0.5, ratio = 0, priority = {-1, 0}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, 0}}), {}),
            [1] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1}, {}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1}, {}),
            [3] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1}, {})),
            [4] = logic_if(lang_jp, logic_if(dir_vt, {1, 0, 0.5, ratio = 0, priority = {-1, 0}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, 0}}), {}),
            [6] = {},
            [7] = {},
            [8] = {},
            [9] = {}
        }
    },

    [6] = { -- 分離禁止類
        chars = {'—', '―', '‥', '…', '⋯', '〳', '〴', '〵'},
        align = 'middle',
        left = 0,
        down = 0,
        width = 1,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        glue = {
            [1] = logic_if(lang_tc, {0.25, 0, 0,25, ratio = 1, priority = {0, 0}}, {}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1, priority = {0, 0}}, {}),
            [3] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.25, ratio = 1, priority = {0, 0}}, {})),
        },
        kern = {
            [6] = 0
        }
    },

    [7] = { -- 開闊號類
    }
}    

    
    
    
    
    
