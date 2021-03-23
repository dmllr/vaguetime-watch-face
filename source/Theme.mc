using Toybox.WatchUi;
using Toybox.Math;

class Theme {
	
	var fontTimeMinutes;
    var fonts;
	
    var colorHour;
    var colorMinute;
    var colorJoin;
    var colorExactMinute;
    var colorApx;

    var screenWidth;
	var cachedFontTimeText;
	var cachedFontApx;
	var cachedFontKey = null;

    function initialize() {
        screenWidth = System.getDeviceSettings().screenWidth;

        fontTimeMinutes = WatchUi.loadResource(Rez.Fonts.fontTimeMinutes);

        fonts = [
            Rez.Fonts.font120,
            Rez.Fonts.font105,
            Rez.Fonts.font88,
            Rez.Fonts.font72,
            Rez.Fonts.font64,
            Rez.Fonts.font52,
            Rez.Fonts.font48,
            Rez.Fonts.font44,
            Rez.Fonts.font36,
            Rez.Fonts.font26,
            Rez.Fonts.font24,
        ];

        // Application.getApp().getProperty("ForegroundColor");
        colorMinute = Graphics.COLOR_YELLOW;
        colorHour = Graphics.COLOR_WHITE;
        colorJoin = 0xafafaf; //Graphics.COLOR_LT_GRAY - 0x202020; //colorMinute - 0x50505000;
        colorExactMinute = colorMinute;
        colorApx = colorJoin;
    }

    function updateFontCache(dc, repr) {
        cachedFontKey = repr.minute;
        
        var fontTimeTextSet = false;
        var fontApxSet = false;
        
        for(var i = 0; i < fonts.size(); i += 1) {
            var font = WatchUi.loadResource(fonts[i]);
            var l1 = dc.getTextWidthInPixels(repr.textTop, font);
            var l2 = dc.getTextWidthInPixels(repr.textBottom, font);

            if (!fontTimeTextSet && l1 < 0.75 * screenWidth && l2 < 0.75 * screenWidth) {
                cachedFontTimeText = font;
                fontTimeTextSet = true;
            }

            l1 = dc.getTextWidthInPixels(repr.date, font);
            if (!fontApxSet && l1 < 0.4 * screenWidth) {
                cachedFontApx = font;
                fontApxSet = true;
            }
        }
        
        if (!fontTimeTextSet) {
            cachedFontTimeText = fonts[fonts.size() - 1];
            fontTimeTextSet = true;
        }
        if (!fontApxSet) {
            cachedFontApx = fonts[fonts.size() - 1];
            fontApxSet = true;
        }
    }

    function getFontForTimeText(dc, repr) {
        if (cachedFontKey == repr.minute) {
            return cachedFontTimeText;
        }

        updateFontCache(dc, repr);

        return cachedFontTimeText;
    }

    function getFontApx(dc, repr) {
        if (cachedFontKey == repr.minute) {
            return cachedFontApx;
        }

        updateFontCache(dc, repr);

        return cachedFontApx;
    }

}
