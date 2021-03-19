using Toybox.WatchUi;

class Theme {
	
	var fontTimeText;
	var fontTimeMinutes;
	
    var colorHour;
    var colorMinute;
    var colorJoin;
    var colorExactMinute;

    function initialize() {
        fontTimeText = WatchUi.loadResource(Rez.Fonts.fontTimeText);
        fontTimeMinutes = WatchUi.loadResource(Rez.Fonts.fontTimeMinutes);

        // Application.getApp().getProperty("ForegroundColor");
        colorMinute = Graphics.COLOR_YELLOW;
        colorHour = Graphics.COLOR_WHITE;
        colorJoin = Graphics.COLOR_DK_GRAY;
        colorExactMinute = Graphics.COLOR_BLUE;
    }
	
}
