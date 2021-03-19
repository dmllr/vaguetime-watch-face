using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;

class WatchFace extends WatchUi.WatchFace {
	
	var in_sleep = false;

	var T;
	var timeEngine;

    function initialize() {
        WatchUi.WatchFace.initialize();

		T = new Theme();

		var deviceSettings = System.getDeviceSettings();
		if (deviceSettings has :systemLanguage) {
			if (deviceSettings.systemLanguage == System.LANGUAGE_RUS) {
				timeEngine = new TimeEngineRus();
			} else {
				timeEngine = new TimeEngine();
			}
		} else {
			timeEngine = new TimeEngine();
		}
    }

    function onUpdate(dc) {
		draw(dc);
	}

    function onExitSleep() {
        in_sleep = false;
    	WatchUi.requestUpdate(); 
    }

    function onEnterSleep() {
    	in_sleep = true;
    	WatchUi.requestUpdate(); 
    }

	function draw(dc) {
		setColors(dc);

		var cw = System.getDeviceSettings().screenWidth  / 2;
		var ch = System.getDeviceSettings().screenHeight / 2;
		var fh = Toybox.Graphics.getFontHeight(T.fontTimeText);
		var justify = Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER;

		var repr = timeEngine.time();
		var text;

		text = revealCase(WatchUi.loadResource(repr.textTop), repr);
		dc.setColor(repr.hourOnTop? T.colorHour : T.colorMinute, Graphics.COLOR_TRANSPARENT);
		dc.drawText(cw, ch - (0.5 * fh), T.fontTimeText, text, justify);
		
		if (repr.textMiddle) {
			dc.setColor(T.colorJoin, Graphics.COLOR_TRANSPARENT);
			dc.drawText(cw, ch, T.fontTimeText, WatchUi.loadResource(repr.textMiddle), justify);
		}
		
		text = revealCase(WatchUi.loadResource(repr.textBottom), repr);
		dc.setColor(repr.hourOnTop? T.colorMinute : T.colorHour, Graphics.COLOR_TRANSPARENT);
		dc.drawText(cw, ch + (0.5 * fh), T.fontTimeText, text, justify);

		// fh = Toybox.Graphics.getFontHeight(T.fontTimeMinutes);
		var hour = revealCase(WatchUi.loadResource(repr.hourOnTop? repr.textBottom : repr.textTop), repr);
		var shift = dc.getTextWidthInPixels(hour, T.fontTimeText) / 2;
		var shiftloc = dc.getTextWidthInPixels("0", T.fontTimeMinutes);
		dc.setColor(T.colorMinute, Graphics.COLOR_TRANSPARENT);
		dc.drawText(cw - shift + shiftloc, ch - (1.0 * fh), T.fontTimeMinutes, ":" + repr.minute.format("%02d"), Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER);
	}

	function revealCase(text, repr) {
		var splitter = text.find("|");
		if (splitter) {
			if (repr.hourCase == 0) {
				text = text.substring(0, splitter);
			} else {
				text = text.substring(splitter + 1, text.length());
			}
		}
		
		return text;
	}

	function setColors(dc) {
		if (in_sleep) {
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
   			dc.clear();
   			dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		} else {
			var bgColor = Graphics.COLOR_BLACK; //Application.getApp().getProperty("BackgroundColor");
			var fgColor = Graphics.COLOR_WHITE; //Application.getApp().getProperty("ForegroundColor");
			dc.setColor(Graphics.COLOR_TRANSPARENT, bgColor);
			dc.clear();
			dc.setColor(fgColor, Graphics.COLOR_TRANSPARENT);
		}
	}
	
	
}
