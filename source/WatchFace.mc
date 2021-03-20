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

		setColor(dc, repr.hourOnTop? T.colorHour : T.colorMinute);
		dc.drawText(cw, ch - (0.5 * fh), T.fontTimeText, repr.textTop, justify);
		
		if (repr.textMiddle) {
			setColor(dc, T.colorJoin);
			dc.drawText(cw, ch, T.fontTimeText, repr.textMiddle, justify);
		}
		
		setColor(dc, repr.hourOnTop? T.colorMinute : T.colorHour);
		dc.drawText(cw, ch + (0.5 * fh), T.fontTimeText, repr.textBottom, justify);

		var text = repr.hourOnTop? repr.textBottom : repr.textTop;
		var shift = dc.getTextWidthInPixels(text, T.fontTimeText) / 2;
		setColor(dc, T.colorMinute);
		dc.drawText(cw + shift, ch - (1.25 * fh), T.fontTimeMinutes, ":" + repr.minute.format("%02d"), Graphics.TEXT_JUSTIFY_RIGHT + Graphics.TEXT_JUSTIFY_VCENTER);
	}

	function setColor(dc, color) {
		if (in_sleep) {
			return;
		}
		dc.setColor(color, Graphics.COLOR_TRANSPARENT);
	}

	function setColors(dc) {
		if (in_sleep) {
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
   			dc.clear();
   			dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		} else {
			var bgColor = Graphics.COLOR_BLACK; //Application.getApp().getProperty("BackgroundColor");
			dc.setColor(Graphics.COLOR_TRANSPARENT, bgColor);
			dc.clear();
		}
	}
	
	
}
