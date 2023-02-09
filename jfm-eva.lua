---- Evangelion Japanese Font Metric for LuaTeX
---- Current Version: 1.0.0 (a)
---- Dev URL: https://github.com/RadioNoiseE/Evangelion-JFM
---- © Copyright 2023, RadioNoiseE


-- 初始化
local lang_jp, lang_tc, lang_sc, dir_vt, font_extd, punc_lg

if luatexja.jfont.jfm_feature
then lang_jp = luatexja.jfont.jfm_feature.jp
     lang_tc = luatexja.jfont.jfm_feature.trad
     lang_sc = luatexja.jfont.jfm_feature.smpl
     dir_vt = luatexja.jfont.jfm_feature.vert
     font_extd = luatexja.jfont.jfm_feature.extd
     punc_lg = luatexja.jfont.jfm_feature.lgp
     std_nil = luatexja.jfont.jfm_feature.nstd
end

-- 預處理及容錯
if font_extd == true and dir_vt == false
then tex.error('JFM feature "extd" only works with feature "vert".\n' ..
               'For now I\'ll ignore it.')
end

if punc_lg == true and dir_vt == false
then tex.error('JFM feature "lgp" only works with feature "vert".\n' ..
               'For now I\'ll ignore it.')
end

if not ((lang_jp and not (lang_tc or lang_sc))
    or  (lang_tc and not (lang_jp or lang_sc))
    or  (lang_sc and not (lang_jp or lang_tc)))
then tex.error('Specify one and only one feature from three language specific features\n' ..
               '"jp", "trad" or "smpl"\n' ..
               'is required.\n' ..
               'For now I\'ll use "lang_jp" for japanese by default.')
end

-- 定義函數宏
local function logic_anif(f1, f2, r1, r2)
     local rta = f1 and (f2 and r1) or r2
     return rta
end

local function logic_if(f1, r1, r2)
     local rti = f1 and r1 or r2
     return rti
end

local function context_height()
    local rth = dir_vt and (font_extd and 0.625 or 0.5) or 0.88
    return rth
end

local function context_depth()
    local rtd = dir_vt and (font_extd and 0.625 or 0.5) or 0.12
    return rtd
end

-- 主體
local eva = {
    version = 3,
    dir = logic_if(dir_vt, 'tate', 'yoko'),
    zw = 1,
    zh = logic_anif(dir_vt, font_extd, 1.25, 1),
    kanjiskip = {0, 0.25, 0},
    xkanjiskip = {0.25, 0.25, 0.125},

    [0] = { -- 缺省類
        width = 1,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = 'middle',
        glue = {
            [1] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}, {}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}, {}),
            [3] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {-1, -1}}, {priority = {0, -1}})),
            [7] = {0.5, 0, 0.25, ratio = 1, priority = {-1, -2}},
            [9] = {0.25, 0, 0.125, ratio = 1, priority = {-1, -1}}
        },
        round_threshold = 0.01
    },

    [1] = { -- 読点類
        chars = logic_anif (dir_vt, punc_lg, {}, {'、', '，'}),
        width = 0.5,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = logic_if (lang_tc, 'middle', 'left'),
        glue = {
            [0] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {-1, -2}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, -2}}),
            [1] = logic_if(lang_tc, {0.5, 0, 0.25}, {0.5, 0, 0.25}),
            [2] = logic_if(lang_tc, {0.5, 0, 0.5}, {0.5, 0, 0.25}),
            [3] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}, {0.5, 0, 0.25, priority = {0, -1}}), logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [4] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {0, 0}, {0, -2})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {0, 0}, {0, -2})}),
            [5] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {0, 0}, {0, -2})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {0, 0}, {0, -2})}),
            [6] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}),
            [7] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}),
            [8] = logic_if(lang_tc, {0.25, 0, 0.125}, {0.5, 0, 0.25, ratio = 0}),
            [9] = logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.75, 0, 0.25, ratio = 1/3, priority = {0, -1}})
        },
        end_adjust = logic_if(lang_tc, {0, 0}, {0.5, 0})
    },

    [101] = { -- 読点類（行間a）
        chars = logic_anif(dir_vt, punc_lg, {'、'}, {}),
        width = 0,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0.38,
        down = -0.34,
        align = 'left'
    },

    [102] = { -- 読点類（行間b）
        chars = logic_anif(dir_vt, punc_lg, {'，'}, {}),
        width = 0,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = logic_if(lang_tc, 0.62, 0.40),
        down = logic_if(lang_tc, -0.58, -0.26),
        align = 'left'
    },

    [2] = { -- 句點類
        chars = logic_anif(dir_vt, punc_lg, {}, {'．', '。'}),
        width = 0.5,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = logic_if(lang_tc, 'middle', 'left'),
        glue = {
            [0] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {-1, 0}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, 0}}),
            [1] = logic_if(lang_tc, {0.5, 0, 0.25}, {0.5, 0, 0.25, ratio = 0}),
            [2] = logic_if(lang_tc, {0.5, 0, 0.25}, {0.5, 0, 0.25, ratio = 0}),
            [3] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}, {0.5, 0, 0.25, priority = {0, -1}}), logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [4] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {0, -2}, {0, 0})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {0, -2}, {0, 0})}),
            [5] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {0, -2}, {0, 0})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {0, -2}, {0, 0})}),
            [6] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}),
            [7] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}),
            [8] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0}, {0.5, 0, 0.25, ratio = 0}),
            [9] = logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.75, 0, 0.25, ratio = 1/3, priority = {0, -1}})
        },
        end_adjust = logic_if(lang_tc, {0, 0}, {0.5, 0})
    },

    [201] = { -- 句點類（行間a）
        chars = logic_anif(dir_vt, punc_lg, {'．'}, {}),
        width = 0,
        height = context_height(),
        depth = context_height(),
        italic = 0,
        left = logic_if(lang_tc, 0.68, 0.34),
        down = logic_if(lang_tc, -0.58, -0.28),
        align = 'left'
    },

    [202] = { -- 句點類（行間b）
        chars = logic_anif(dir_vt, punc_lg, {'。'}, {}),
        width = 0,
        height = context_height(),
        depth = context_height(),
        italic = 0,
        left = 0.42,
        down = -0.35,
        align = 'left'
    },

    [3] = { -- 兩點類
        chars = logic_if(lang_jp, {}, (logic_anif(dir_vt, punc_lg, {}, {'：', '；'}))),
        width = logic_if(dir_vt, 1, 0.5),
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = logic_if(lang_tc, 'middle', 'left'),
        glue = {
            [0] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {-1, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, -1}})),
            [1] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}, {priority = {0, -1}}), logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [2] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}, {priority = {0, -1}}), logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [3] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [4] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [5] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [6] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {-1, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, -1}})),
            [7] = logic_if(dir_vt, {}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {-1, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, -1}})),
            [8] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}}),
            [9] = logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.75, 0, 0.25, ratio = 1/3, priority = {0, -1}})
        }
    },

    [301] = { -- 兩點類（行間a）
        chars = logic_if(lang_jp, {}, logic_anif(dir_vt, punc_lg, {'：'}, {})),
        width = 0,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = logic_if(lang_tc, 0.94, 0.72),
        down = logic_if(lang_tc, -0.58, -0.34),
        align = 'left'
    },

    [302] = { -- 兩點類（行間b）
        chars = logic_if(lang_jp, {}, logic_anif(dir_vt, punc_lg, {'；'}, {})),
        width = 0,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = logic_if(lang_tc, 0.96, 0.78),
        down = logic_if(lang_tc, -0.58, -0.34),
        align = 'left'
    },

    [4] = { -- 小書きの仮名類
        chars = {
            'ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ', 'っ', 'ゃ', 'ゅ', 'ょ', 'ゎ', 'ゕ',
            'ゖ', 'ゝ', 'ゞ', 'ァ', 'ィ', 'ゥ', 'ェ', 'ォ', 'ッ', 'ャ', 'ュ',
            'ョ', 'ヮ', 'ヵ', 'ヶ', 'ヽ', 'ヾ', 'ㇰ', 'ㇱ', 'ㇲ', 'ㇳ', 'ㇴ',
            'ㇵ', 'ㇶ', 'ㇷ', 'ㇸ', 'ㇹ', 'ㇺ', 'ㇻ', 'ㇼ', 'ㇽ', 'ㇾ', 'ㇿ',
        },
        width = 1,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = 'middle',
        glue = {
            [1] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, {}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, {}),
            [3] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}, {priority = {0, -1}}),
            [7] = {0.5, 0, 0.25, ratio = 1, priority = {-1, -2}},
            [9] = {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}
        }
    },

    [5] = { -- 疑問感嘆類
        chars = {'！', '？', '‼︎', '⁉︎', '⁈', '⁇'},
        width = 1,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = 'middle',
        glue = {
            [0] = logic_if(lang_jp, logic_if(dir_vt, {1, 0, 0.5, ratio = 0, priority = {-1, 0}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, 0}}), {ipririty = {-1, 0}}),
            [1] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, {}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, {}),
            [3] = logic_if(dir_vt, {priority = {-1, -1}}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {-1, -1}}, {priority = {-1, -1}})),
            [4] = logic_if(lang_jp, logic_if(dir_vt, {1, 0, 0.5, ratio = 0}, {0.5, 0, 0.25, ratio = 0}), {}),
            [7] = {0.5, 0, 0.25, ratio = 1, priority = {-1, -2}},
            [9] = {0.25, 0, 0.125, ratio = 1, priority = {-1, -1}}
        }
    },

    [6] = { -- 分離禁止類
        chars = {'—', '―', '‥', '…', '⋯', '〳', '〴', '〵'},
        width = 1,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = 'middle',
        kern = {
            [6] = 0
        },
        glue = {
            [1] = logic_if(lang_tc, {0.25, 0, 0,125, ratio = 1}, {}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, {}),
            [3] = logic_if(dir_vt, {priority = {0, -1}}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}, {priority = {0, -1}})),
            [7] = {0.5, 0, 0.25, ratio = 1, priority = {-1, -2}},
            [9] = {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}
        }
    },

    [7] = { -- 開括號類
        chars = {'（', '〔', '［', '｛', '〈', '《', '「', '『', '【', '｟', '〘', '〖', '〝', '‘', '“'},
        width = 0.5,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = 'right',
        glue = {
            [1] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, {}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, {}),
            [3] = logic_if(dir_vt, {priority = {0, -1}}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}, {priority = {0, -1}})),
            [7] = {0, 0, 0, priority = {0, 0}, kanjiskip_shrink = 1},
            [9] = {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}
        }
    },

    [8] = { -- 閉括號類
        chars = {'）', '〕', '］', '｝', '〉', '》', '」', '』', '】', '｠', '〙', '〗', '〟', '’', '”'},
        width = 0.5, 
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = 'left',
        glue = {
            [0] = {0.5, 0, 0.25, ratio = 0, priority = {-1, -2}},
            [1] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, {}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, {}),
            [3] = logic_if(lang_sc, {}, {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}),
            [4] = {0.5, 0, 0.25, ratio = 0, priority = {0, -2}},
            [5] = {0.5, 0, 0.25, ratio = 0, priority = {0, -2}},
            [6] = {0.5, 0, 0.25, ratio = 0, priroity = {-1, -2}},
            [7] = {0.5, 0, 0.25, ratio = 0, priority = {-1, -2}, kanjiskip_stretch = 1},
            [8] = {0, 0, 0, priority = {0, 0}, kanjiskip_shrink = 1},
            [9] = {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}
        }
    },

    [9] = { -- 中點類
        chars = logic_if(lang_jp, {'・', '：', '；'}, {'・', '·'}),
        width = 0.5,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = 'middle',
        glue = {
            [0] = {0.25, 0, 0.125, ratio = 0, priority = {-1, -1}},
            [1] = logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}),
            [2] = logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}),
            [3] = logic_if(dir_vt, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}, logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.25, 0, 0.125, priority = {0, -1}})),
            [4] = {0.25, 0, 0.125, ratio = 0, priority = {0, -1}},
            [5] = {0.25, 0, 0.125, ratio = 0, priority = {0, -1}},
            [6] = {0.25, 0, 0.125, ratio = 0, priority = {-1, -1}},
            [7] = {0.25, 0, 0.125, ratio = 0, priority = {-1, -1}},
            [8] = {0.25, 0, 0.125, ratio = 0, priority = {0, -1}},
            [9] = {0.5, 0, 0.25, priority = {0, -1}}
        }
    },

    [10] = { -- 行頭
        chars = {'boxbdd', 'parbdd'},
        glue = {
            [7] = {0, 0, 0}
        }
    },

    [101] = { -- 伸縮膠
        chars = {'glue'}
    }
}    

luatexja.jfont.define_jfm(eva)
