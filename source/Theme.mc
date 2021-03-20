using Toybox.WatchUi;

class Theme {
	
	var fontDateText;
	var fontTimeText;
	var fontTimeMinutes;
	var fontBatteryText;
	
    var colorHour;
    var colorMinute;
    var colorJoin;
    var colorExactMinute;
    var colorDate;

    function initialize() {
        fontDateText = WatchUi.loadResource(Rez.Fonts.fontDateText);
        fontTimeText = WatchUi.loadResource(Rez.Fonts.fontTimeText);
        fontTimeMinutes = WatchUi.loadResource(Rez.Fonts.fontTimeMinutes);
        fontBatteryText = WatchUi.loadResource(Rez.Fonts.fontBatteryText);

        // Application.getApp().getProperty("ForegroundColor");
        colorMinute = Graphics.COLOR_YELLOW;
        colorHour = Graphics.COLOR_WHITE;
        colorJoin = Graphics.COLOR_DK_GRAY;
        colorExactMinute = Graphics.COLOR_BLUE;
        colorDate = Graphics.COLOR_DK_GRAY;
    }

}
