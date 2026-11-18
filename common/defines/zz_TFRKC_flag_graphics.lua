-- HOI4 1.19: graphics defines belong to NDefines_Graphics.
-- HOI4 1.19.5's compact atlas path truncates the last page's row count.
-- With the current 732 registered tags, use 6 / 12 / 12 columns so
-- every real country fits, including countries activated during civil war.
-- Do not increase these blindly. Run validate-flag-graphics-hotfix-20261118.cjs
-- after changing dependencies or adding tags; see docs/CRASH_REVIEW_20261118_ko.md.
NDefines_Graphics.NGraphics.COUNTRY_FLAG_TEX_MAX_SIZE = 512
NDefines_Graphics.NGraphics.COUNTRY_FLAG_MEDIUM_TEX_MAX_SIZE = 512
NDefines_Graphics.NGraphics.COUNTRY_FLAG_SMALL_TEX_MAX_SIZE = 128
