using Toybox.WatchUi;
using Toybox.Math;

class Theme {
	
    var fonts;
	var fontTimeMinutes;
	var fontIcons;
	var fontTyny;
	
    var colorHour;
    var colorMinute;
    var colorJoin;
    var colorExactMinute;
    var colorApx;
    var colorWarning;
    var colorInactive;

    var screenWidth;
	var cachedFontTimeText;
	var cachedFontApx;
	var cachedFontKey = null;

    const SYMBOL_BT_ON = "A";
    const SYMBOL_BT_OFF = "a";
    const SYMBOL_NOTIFICATIONS = "D";

    function initialize() {
        screenWidth = System.getDeviceSettings().screenWidth;

        fontTimeMinutes = WatchUi.loadResource(Rez.Fonts.fontTimeMinutes);
        fontIcons = WatchUi.loadResource(Rez.Fonts.fontIcons);
        fontTyny = WatchUi.loadResource(Rez.Fonts.font24);

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
        colorWarning = Graphics.COLOR_ORANGE;
        colorInactive = 0x1f1f1f;
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
            if (!fontApxSet && l1 < 0.33 * screenWidth) {
                cachedFontApx = font;
                fontApxSet = true;
            }
        }
        
        if (!fontTimeTextSet) {
            cachedFontTimeText = WatchUi.loadResource(fonts[fonts.size() - 1]);
            fontTimeTextSet = true;
        }
        if (!fontApxSet) {
            cachedFontApx = WatchUi.loadResource(fonts[fonts.size() - 1]);
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
