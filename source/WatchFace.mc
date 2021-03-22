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
		var justify = Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER;
		var fh;

		var repr = timeEngine.time();

		var font = T.getFontApx(dc, repr);
		fh = Toybox.Graphics.getFontHeight(font);
		setColor(dc, T.colorDate);
		dc.drawText(cw, (0.5 * fh), font, repr.date, justify);

		setColor(dc, T.colorDate);
		dc.drawText(cw, 2 * ch - (0.5 * fh), font, repr.battery, justify);

		font = T.getFontForTimeText(dc, repr);

		fh = Toybox.Graphics.getFontHeight(font);

		if (repr.textMiddle) {
			setColor(dc, T.colorJoin);
			dc.drawText(cw, ch, font, repr.textMiddle, justify);
		}
		
		setColor(dc, repr.hourOnTop? T.colorHour : T.colorMinute);
		dc.drawText(cw, ch - (0.5 * fh), font, repr.textTop, justify);
		
		setColor(dc, repr.hourOnTop? T.colorMinute : T.colorHour);
		dc.drawText(cw, ch + (0.5 * fh), font, repr.textBottom, justify);

		var text = repr.hourOnTop? repr.textBottom : repr.textTop;
		var shift = dc.getTextWidthInPixels(text, font) / 2;
		setColor(dc, T.colorMinute);
		dc.drawText(cw + shift, ch - fh - 6, T.fontTimeMinutes, ":" + repr.minute.format("%02d"), Graphics.TEXT_JUSTIFY_RIGHT + Graphics.TEXT_JUSTIFY_VCENTER);
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
