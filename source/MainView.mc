using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;

class MainView extends WatchUi.WatchFace {
	
	var in_sleep = false;

	var fontCollection;
	var timeEngine;

    function initialize() {
        WatchUi.WatchFace.initialize();

		fontCollection = new FontCollection();
		timeEngine = new TimeEngine();
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
		var font = fontCollection.fontTimeText;
		var fh = Toybox.Graphics.getFontHeight(font);

		var repr = timeEngine.time();

		dc.setColor(repr.colorTop, Graphics.COLOR_TRANSPARENT);
		dc.drawText(cw, ch - (1.0 * fh), font, WatchUi.loadResource(repr.textTop), Graphics.TEXT_JUSTIFY_CENTER);
		
		if (repr.textMiddle) {
			dc.setColor(repr.colorMiddle, Graphics.COLOR_TRANSPARENT);
			dc.drawText(cw, ch - (0.5 * fh), font, WatchUi.loadResource(repr.textMiddle), Graphics.TEXT_JUSTIFY_CENTER);
		}
		
		if (repr.textBottom) {
			dc.setColor(repr.colorBottom, Graphics.COLOR_TRANSPARENT);
			dc.drawText(cw, ch - (0.0 * fh), font, WatchUi.loadResource(repr.textBottom), Graphics.TEXT_JUSTIFY_CENTER);
		}
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
