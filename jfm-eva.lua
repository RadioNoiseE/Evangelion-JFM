---- Evangelion Japanese Font Metric for LuaTeX
---- Current Version: 1.0.5 (b)
---- Dev URL: https://github.com/RadioNoiseE/Evangelion-JFM
---- Copyright 2023, RadioNoiseE ©


-- 初始化
local lang_jp, lang_tc, lang_sc, dir_vt, font_extd, punc_lg, punc_hg, std_nil, al_hw, al_fw, as_nil, fw_prop, fw_xprop

if luatexja.jfont.jfm_feature then 
    lang_jp = luatexja.jfont.jfm_feature.jp
    lang_tc = luatexja.jfont.jfm_feature.trad
    lang_sc = luatexja.jfont.jfm_feature.smpl
    dir_vt = luatexja.jfont.jfm_feature.vert
    font_extd = luatexja.jfont.jfm_feature.extd
    punc_lg = luatexja.jfont.jfm_feature.lgp
    punc_hg = luatexja.jfont.jfm_feature.hgp
    std_nil = luatexja.jfont.jfm_feature.nstd
    al_hw = luatexja.jfont.jfm_feature.hwid
    al_fw = luatexja.jfont.jfm_feature.fwid
    as_nil = luatexja.jfont.jfm_feature.plain
    fw_prop = luatexja.jfont.jfm_feature.prop
    fw_xprop = luatexja.jfont.jfm_feature.propw
end

-- 預處理及容錯
if font_extd == true and dir_vt == false then
    tex.error('JFM feature "extd" only works with feature "vert".\n' ..
              'For now I\'ll ignore it.')
    luatexja.jfont.jfm_feature["extd"] = nil
end

if punc_lg == true and dir_vt == false then
    tex.error('JFM feature "lgp" only works with feature "vert".\n' ..
              'For now I\'ll ignore it.')
    luatexja.jfont.jfm_feature["lgp"] = nil
end

if al_hw == true and al_fw == true then
    tex.error('JFM feature "hwid" cannot be used with "fwid".\n' ..
              'For now I\'ll ignore both.')
    luatexja.jfont.jfm_feature["hwid"] = nil
    luatexja.jfont.jfm_feature["fwid"] = nil
end

if fw_prop == true and fw_xprop == true then
    tex.error('JFM feature "prop" cannot be used with "propw".\n' ..
              'For now I\'ll ignore both.')
    luatexja.jfont.jfm_feature["prop"] = nil
    luatexja.jfont.jfm_feature["propw"] = nil
end

if not ((lang_jp and not (lang_tc or lang_sc)) or
        (lang_tc and not (lang_jp or lang_sc)) or
        (lang_sc and not (lang_jp or lang_tc))) then
    tex.error('Specify one and only one feature from three language specific features\n' ..
              '"jp", "trad" or "smpl"\n' ..
              'is required.\n' ..
              'For now I\'ll use "lang_jp" for japanese by default.')
    luatexja.jfont.jfm_feature["jp"] = "eva_langfeat_defl"
end

-- 壓縮比例設定
if font_extd == true then
    local extd_ratio = (type(font_extd) == 'string') and tonumber(font_extd) or 1.25
end

-- 行間標點字間距補足
local lgp_kanjiskip = {kanjiskip_natural = 0, kanjiskip_stretch = 1, kanjiskip_shrink = 1}

-- 定義函數宏
local function logic_anif(f1, f2, r1, r2)
    local rta = f1 and (f2 and r1) or r2
    return rta
end

local function logic_orif(f1, f2, r1, r2)
    local rto = (f1 or f2) and r1 or r2
    return rto
end

local function logic_if(f1, r1, r2)
    local rti = f1 and r1 or r2
    return rti
end

local function context_width(regv)
    local rtw = (fw_prop or fw_xprop) and 'prop' or (regv)
    return rtw
end

local function context_height()
    local rth = dir_vt and (font_extd and extd_ratio/2 or 0.5) or 0.88
    return rth
end

local function context_depth()
    local rtd = dir_vt and (font_extd and extd_ratio/2 or 0.5) or 0.12
    return rtd
end

-- 主體
local eva = {
    version = 3,
    dir = logic_if(dir_vt, 'tate', 'yoko'),
    zw = 1,
    zh = logic_anif(dir_vt, font_extd, extd_ratio, 1),
    kanjiskip = {0, 0.25, 0},
    xkanjiskip = {0.25, 0.125, 0.125},

    [0] = { -- 缺省類
        width = context_width(1),
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = 'middle',
        glue = {
            [1] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}, {priority = logic_if(std_nil, {-1, 0}, {-1, -2})}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}, {priority = logic_if(std_nil, {-1, -2}, {-1, 0})}),
            [3] = logic_if(dir_vt, {priority = {0, -1}}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {-1, -1}}, {priority = {-1, -1}})),
            [7] = {0.5, 0, 0.25, ratio = 1, priority = {-1, -2}},
            [9] = {0.25, 0, 0.125, ratio = 1, priority = {-1, -1}}
        },
        round_threshold = 0.01
    },

    [1] = { -- 読点類
        chars = logic_anif(dir_vt, punc_lg, {}, {'、', '，'}),
        width = context_width(0.5),
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = logic_if(lang_tc, 'middle', 'left'),
        glue = {
            [0] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}),
            [1] = logic_if(lang_tc, {0.5, 0, 0.25}, {0.5, 0, 0.25}),
            [2] = logic_if(lang_tc, {0.5, 0, 0.25}, {0.5, 0, 0.25}),
            [3] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}, {0.5, 0, 0.25, priority = {0, -1}}), logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [4] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {0, 0}, {0, -2})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {0, 0}, {0, -2})}),
            [5] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {0, 0}, {0, -2})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {0, 0}, {0, -2})}),
            [6] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}),
            [7] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {-1, 0}, {-1, -2})}),
            [8] = logic_if(lang_tc, {0.25, 0, 0.125}, {}),
            [9] = logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.75, 0, 0.25, ratio = 1/3, priority = {0, -1}})
        },
        end_adjust = logic_if(lang_tc, {0.25, 0, 0.25}, logic_if(punc_hg, {-0.5, 0.5, 0}, {0, 0}))
    },

    [101] = { -- 読点類（行間a）
        chars = logic_anif(dir_vt, punc_lg, {'、'}, {}),
        width = 0,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0.38,
        down = -0.34,
        align = 'left',
        glue = {
            [0] = lgp_kanjiskip
        }
    },

    [102] = { -- 読点類（行間b）
        chars = logic_anif(dir_vt, punc_lg, {'，'}, {}),
        width = 0,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = logic_if(lang_tc, 0.62, 0.40),
        down = logic_if(lang_tc, -0.58, -0.26),
        align = 'left',
        glue = {
            [0] = lgp_kanjiskip
        }
    },

    [2] = { -- 句點類
        chars = logic_anif(dir_vt, punc_lg, {}, {'．', '。'}),
        width = context_width(0.5),
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = logic_if(lang_tc, 'middle', 'left'),
        glue = {
            [0] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}),
            [1] = logic_if(lang_tc, {0.5, 0, 0.25}, {0.5, 0, 0.25, ratio = 0}),
            [2] = logic_if(lang_tc, {0.5, 0, 0.25}, {0.5, 0, 0.25, ratio = 0}),
            [3] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}, {0.5, 0, 0.25, priority = {0, -1}}), logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [4] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {0, -2}, {0, 0})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {0, -2}, {0, 0})}),
            [5] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {0, -2}, {0, 0})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {0, -2}, {0, 0})}),
            [6] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}),
            [7] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}, {0.5, 0, 0.25, ratio = 0, priority = logic_if(std_nil, {-1, -2}, {-1, 0})}),
            [8] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0}, {}),
            [9] = logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.75, 0, 0.25, ratio = 1/3, priority = {0, -1}})
        },
        end_adjust = logic_if(lang_tc, {0.25, 0, 0.25}, logic_if(punc_hg, {-0.5, 0.5, 0}, {0, 0}))
    },

    [201] = { -- 句點類（行間a）
        chars = logic_anif(dir_vt, punc_lg, {'．'}, {}),
        width = 0,
        height = context_height(),
        depth = context_height(),
        italic = 0,
        left = logic_if(lang_tc, 0.68, 0.34),
        down = logic_if(lang_tc, -0.58, -0.28),
        align = 'left',
        glue = {
            [0] = lgp_kanjiskip
        }
    },

    [202] = { -- 句點類（行間b）
        chars = logic_anif(dir_vt, punc_lg, {'。'}, {}),
        width = 0,
        height = context_height(),
        depth = context_height(),
        italic = 0,
        left = 0.42,
        down = -0.35,
        align = 'left',
        glue = {
            [0] = lgp_kanjiskip
        }
    },

    [3] = { -- 兩點類
        chars = logic_if(lang_jp, {}, (logic_anif(dir_vt, punc_lg, {}, {'：', '；'}))),
        width = context_width(logic_if(dir_vt, 1, 0.5)),
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = logic_if(lang_tc, 'middle', 'left'),
        glue = {
            [0] = logic_if(dir_vt, {priority = {-1, -1}}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {-1, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, -1}})),
            [1] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}, {priority = {0, -1}}), logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [2] = logic_if(dir_vt, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}, {priority = {0, -1}}), logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [3] = logic_if(dir_vt, {priority = {0, -1}}, logic_if(lang_tc, {0.5, 0, 0.25, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [4] = logic_if(dir_vt, {priority = {0, -1}}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [5] = logic_if(dir_vt, {priority = {0, -1}}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {0, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {0, -1}})),
            [6] = logic_if(dir_vt, {priority = {-1, -1}}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {-1, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, -1}})),
            [7] = logic_if(dir_vt, {priority = {-1, -1}}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 0, priority = {-1, -1}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, -1}})),
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
        align = 'left',
        glue = {
            [0] = lgp_kanjiskip
        }
    },

    [302] = { -- 兩點類（行間b）
        chars = logic_if(lang_jp, {}, logic_anif(dir_vt, punc_lg, {'；'}, {})),
        width = 0,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = logic_if(lang_tc, 0.96, 0.78),
        down = logic_if(lang_tc, -0.58, -0.34),
        align = 'left',
        glue = {
            [0] = lgp_kanjiskip
        }
    },

    [4] = { -- 小書きの仮名類
        chars = {
            'ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ', 'っ', 'ゃ', 'ゅ', 'ょ', 'ゎ', 'ゕ',
            'ゖ', 'ゝ', 'ゞ', 'ァ', 'ィ', 'ゥ', 'ェ', 'ォ', 'ッ', 'ャ', 'ュ',
            'ョ', 'ヮ', 'ヵ', 'ヶ', 'ヽ', 'ヾ', 'ㇰ', 'ㇱ', 'ㇲ', 'ㇳ', 'ㇴ',
            'ㇵ', 'ㇶ', 'ㇷ', 'ㇸ', 'ㇹ', 'ㇺ', 'ㇻ', 'ㇼ', 'ㇽ', 'ㇾ', 'ㇿ'
        },
        width = context_width(1),
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
        width = context_width(logic_if(dir_vt, 1, logic_if(lang_sc, 0.5, 1))),
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = logic_if(dir_vt, 'middle', logic_if(lang_sc, 'left', 'middle')),
        glue = {
            [0] = logic_if(dir_vt, logic_if(lang_jp, {1, 0, 0.5, ratio = 0, priority = {-1, 0}}, {priority = {-1, 0}}), logic_if(lang_tc, {priority = {-1, 0}}, {0.5, 0, 0.25, ratio = 0, priority = {-1, 0}})),
            [1] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, logic_anif(not dir_vt, lang_sc, {0.5, 0, 0.25, ratio = 0}, {})),
            [2] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, logic_anif(not dir_vt, lang_sc, {0.5, 0, 0.25, ratio = 0}, {})),
            [3] = logic_if(dir_vt, {priority = {-1, -1}}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {-1, -1}}, {0.75, 0, 0.25, ratio = 1/3, priority = {-1, -1}})),
            [4] = logic_if(dir_vt, logic_if(lang_jp, {1, 0, 0.5, ratio = 0}, {}), logic_if(lang_tc, {}, {0.5, 0, 0.25, ratio = 0})),
            [7] = {0.5, 0, 0.25, ratio = 1, priority = {-1, -2}},
            [8] = logic_anif(not dir_vt, lang_sc, {0.5, 0, 0.25, ratio = 0}, {}),
            [9] = logic_anif(not dir_vt, lang_sc, {0.75, 0, 0.25, ratio = 1/3, priority = {-1, -1}}, {0.25, 0, 0.125, ratio = 1, priority = {-1, -1}})
        }
    },

    [6] = { -- 分離禁止類
        chars = {'—', '―', '‥', '…', '⋯', '〳', '〴', '〵'},
        width = context_width(1),
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

    [601] = { -- 二連字
        chars = {'⸺'},
        width = context_width(2),
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = 'middle',
        glue = {
            [1] = logic_if(lang_tc, {0.25, 0, 0,125, ratio = 1}, {}),
            [2] = logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1}, {}),
            [3] = logic_if(dir_vt, {priority = {0, -1}}, logic_if(lang_tc, {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}, {priority = {0, -1}})),
            [7] = {0.5, 0, 0.25, ratio = 1, priority = {-1, -2}},
            [9] = {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}
        }
    },

    [602] = { -- 三連字
        chars = {'⸻'},
        width = context_width(3),
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = 'middle',
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
        width = context_width(0.5),
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
        width = context_width(0.5), 
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
            [3] = logic_if(lang_sc, {priority = {0, -1}}, {0.25, 0, 0.125, ratio = 1, priority = {0, -1}}),
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
        width = context_width(0.5),
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
        },
        end_adjust = {0.25, 0, 0.25}
    },

    [10] = { -- 西文
        chars = {},
        width = 0,
        height = context_height(),
        depth = context_depth(),
        italic = 0,
        left = 0,
        down = 0,
        align = 'middle',
        glue = {}
    },

    [11] = { -- 行頭
        chars = {'parbdd', 'boxbdd'},
        glue = {
            [7] = {0, 0, 0}
        }
    }
}

if al_hw == true or al_fw == true then
    eva[10].chars = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
                     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                     'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                     'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}
    eva[10].glue = table.fastcopy(eva[0].glue)
    eva[10].glue[0] = {0.25, 0.125, 0.125, ratio = 0, priority = {0, -1}}
    eva[0].glue[10] = {0.25, 0.125, 0.125, ratio = 1, priority = {0, -1}}
    for _, catnum in ipairs({1, 2, 3, 5, 8, 9}) do
        eva[catnum].glue[10] = table.fastcopy(eva[catnum].glue[0])
    end
end

if al_hw == true and al_fw == false then
    eva[10].width = 0.5
end

if al_fw == false and al_hw == true then
    eva[10].width = 1
end

if fw_prop == true and fw_xprop == false then
    for _, catnum in ipairs({0, 1, 101, 102, 2, 201, 202, 3, 301, 302, 4, 5, 6, 7, 8, 9, 10}) do
      eva[catnum].glue = {}
    end
end

if sa_nil == true then
  for _, catnum in ipairs({1, 101, 102, 2, 201, 202, 3, 301, 302, 4, 5, 6, 7, 8, 9, 10, 11}) do
    eva[catnum] = nil
  end
  eva[0].glue = {}
end

luatexja.jfont.define_jfm(eva)
