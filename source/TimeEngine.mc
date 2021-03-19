using Toybox.WatchUi;

class TimeRepresentation {
    var hour;
    var minute;

    var textTop;
    var colorTop;
    var textMiddle;
    var colorMiddle;
    var textBottom;
    var colorBottom;
}

class TimeEngine {
    function time() {
        var time = System.getClockTime();
        var hour = time.hour;
        var minute = time.min;
        var nextHour = hour + 1;
        if (nextHour > 23) {
            nextHour = 0;
        }

        var colorMinute = Graphics.COLOR_YELLOW;
        var colorHour = Graphics.COLOR_WHITE;

        var repr = new TimeRepresentation();
        repr.hour = hour;
        repr.minute = minute;
        repr.colorMiddle = Graphics.COLOR_DK_GRAY;

        if (minute < 5) {
            repr.textTop =  hour_map[hour];
            repr.colorTop = colorHour;
            repr.textBottom =  Rez.Strings.exact;
            repr.colorBottom =  colorMinute;
        } else if (minute >= 5 && minute < 10) {
            repr.textTop = Rez.Strings.some;
            repr.colorTop = colorMinute;
            repr.textMiddle = Rez.Strings.past;
            repr.textBottom = hour_map[hour];
            repr.colorBottom = colorHour;
        } else if (minute >= 10 && minute <= 20) {
            repr.textTop = Rez.Strings.quarter;
            repr.colorTop = colorMinute;
            repr.textMiddle = Rez.Strings.past;
            repr.textBottom = hour_map[hour];
            repr.colorBottom = colorHour;
        } else if (minute > 20 && minute < 40) {
            repr.textTop = Rez.Strings.half;
            repr.colorTop = colorMinute;
            repr.textMiddle = Rez.Strings.past;
            repr.textBottom = hour_map[hour];
            repr.colorBottom = colorHour;
        } else if (minute >= 40 && minute <= 50) {
            repr.textTop = Rez.Strings.quarter;
            repr.colorTop = colorMinute;
            repr.textMiddle = Rez.Strings.to;
            repr.textBottom = hour_map[nextHour];
            repr.colorBottom = colorHour;
        } else if (minute > 50 && minute <= 55) {
            repr.textTop = Rez.Strings.about;
            repr.textBottom = hour_map[nextHour];
        } else if (minute > 55) {
            repr.textTop = hour_map[nextHour];
            repr.colorTop = colorHour;
            repr.textBottom =  Rez.Strings.exact;
            repr.colorBottom = colorMinute;
        }

        return repr;
    }

    var hour_map = {
        1 => Rez.Strings.hour_1,
        2 => Rez.Strings.hour_2,
        3 => Rez.Strings.hour_3,
        4 => Rez.Strings.hour_4,
        5 => Rez.Strings.hour_5,
        6 => Rez.Strings.hour_6,
        7 => Rez.Strings.hour_7,
        8 => Rez.Strings.hour_8,
        9 => Rez.Strings.hour_9,
        10 => Rez.Strings.hour_10,
        11 => Rez.Strings.hour_11,
        12 => Rez.Strings.hour_12,
        13 => Rez.Strings.hour_13,
        14 => Rez.Strings.hour_14,
        15 => Rez.Strings.hour_15,
        16 => Rez.Strings.hour_16,
        17 => Rez.Strings.hour_17,
        18 => Rez.Strings.hour_18,
        19 => Rez.Strings.hour_19,
        20 => Rez.Strings.hour_20,
        21 => Rez.Strings.hour_21,
        22 => Rez.Strings.hour_22,
        23 => Rez.Strings.hour_23,
        24 => Rez.Strings.hour_24,
        0 => Rez.Strings.hour_0,
    };
}