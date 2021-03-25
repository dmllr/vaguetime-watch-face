using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Math;

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
		var font;
		var fh;

		var repr = timeEngine.time();

		font = T.getFontApx(dc, repr);
		fh = Toybox.Graphics.getFontHeight(font);
		setColor(dc, T.colorApx);
		dc.drawText(cw, 2 * ch - (0.6 * fh), font, repr.date, justify);

		font = T.getFontForTimeText(dc, repr);

		fh = Toybox.Graphics.getFontHeight(font);
		var shiftY = fh * 0.2;

		if (repr.textMiddle) {
			setColor(dc, T.colorJoin);
			dc.drawText(cw, ch + shiftY, font, repr.textMiddle, justify);
		}
		
		setColor(dc, repr.hourOnTop? T.colorHour : T.colorMinute);
		dc.drawText(cw, ch - (0.5 * fh) + shiftY, font, repr.textTop, justify);
		
		setColor(dc, repr.hourOnTop? T.colorMinute : T.colorHour);
		dc.drawText(cw, ch + (0.5 * fh) + shiftY, font, repr.textBottom, justify);

		var text = repr.hourOnTop? repr.textBottom : repr.textTop;
		var shiftX = dc.getTextWidthInPixels(text, font) / 2;
		setColor(dc, T.colorExactMinute);
		dc.drawText(cw + shiftX, ch - fh - 6 + shiftY, T.fontTimeMinutes, ":" + repr.minute.format("%02d"), Graphics.TEXT_JUSTIFY_RIGHT + Graphics.TEXT_JUSTIFY_VCENTER);

		font = T.fontIcons;

		fh = Toybox.Graphics.getFontHeight(font);
		var sz = dc.getTextWidthInPixels(T.SYMBOL_BT_ON, font);

		setColor(dc, T.colorApx);
		drawBatteryMeter(dc, cw, 1.1 * fh, 0.8 * sz, 0.95 * fh);
		dc.drawText(cw, 2 * fh, T.fontTyny, repr.battery, justify);

		shiftX = 1.66 * sz;
		if (repr.phoneConnected) {
			setColor(dc, T.colorApx);
			dc.drawText(cw + shiftX, fh, T.fontIcons, T.SYMBOL_BT_ON, justify);
		} else {
			setColor(dc, T.colorWarning);
			dc.drawText(cw + shiftX, fh, T.fontIcons, T.SYMBOL_BT_OFF, justify);
		}

		setColor(dc, repr.notificationCount? T.colorApx : T.colorInactive);
		dc.drawText(cw - (1.2 * shiftX), fh, T.fontIcons, T.SYMBOL_NOTIFICATIONS, justify);
		dc.drawText(cw - (1.2 * shiftX), 2 * fh, T.fontTyny, repr.notificationCount, justify);
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
	
	function drawBatteryMeter(dc, x, y, width, height) {
		var gThemeColour = Graphics.COLOR_ORANGE;
		var SCREEN_MULTIPLIER = 1;
		var BATTERY_MARGIN = 1;
		var BATTERY_HEAD_HEIGHT = 4;

		dc.setPenWidth(/* BATTERY_LINE_WIDTH */ 2);

		// Body
		dc.drawRoundedRectangle(
			x - (width / 2) + 1,
			y - (height / 2) + 1,
			width - 1,
			height - 1,
			2 * SCREEN_MULTIPLIER
		);

		// Head
		dc.fillRoundedRectangle(
			x - (width / 4),
			y - (height / 2) - BATTERY_MARGIN - 2,
			(width / 2),
			BATTERY_HEAD_HEIGHT,
			2 * SCREEN_MULTIPLIER
		);

		// Fill
		var batteryLevel = Math.floor(System.getSystemStats().battery);		

		// Fill colour based on battery level.
		var fillColour;
		if (batteryLevel <= 20) {
			setColor(dc, Graphics.COLOR_RED);
		} else if (batteryLevel <= 50) {
			setColor(dc, Graphics.COLOR_YELLOW);
		} else {
			// default drawing color
		}

		var lineWidthPlusMargin = (2 + BATTERY_MARGIN);
		var fillHeight = height - (2 * lineWidthPlusMargin);
		var fillLevel = Math.ceil(fillHeight * (batteryLevel / 100));
		dc.fillRectangle(
			x - (width / 2) + lineWidthPlusMargin,
			y - (height / 2) + (fillHeight - fillLevel) + lineWidthPlusMargin,
			width - (2 * lineWidthPlusMargin),
			fillLevel
		);
	}
	
}
