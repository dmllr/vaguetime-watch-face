using Toybox.WatchUi;
using Toybox.Time.Gregorian;


class TimeEngine {
    protected function timeRepr() {
        var repr = new TimeRepresentation();
        repr.hourOnTop = false;

        var now = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        repr.hour = now.hour;
        repr.minute = now.min;
        repr.nextHour = repr.hour + 1;
        if (repr.nextHour > 23) {
            repr.nextHour = 0;
        }

        repr.date = WatchUi.loadResource(monthMap[now.month]) + " " + now.day + ", " + WatchUi.loadResource(dowMap[now.day_of_week]);

        repr.battery = System.getSystemStats().battery.format("%d") + "%";
        
        return repr;
    }

    function time() {
        var repr = timeRepr();

        if (repr.minute < 5) {
            repr.hourOnTop = true;
            repr.textTop =  hourMap[repr.hour];
            repr.textBottom =  Rez.Strings.exact;
        } else if (repr.minute >= 5 && repr.minute < 10) {
            repr.textTop = Rez.Strings.near;
            repr.textMiddle = Rez.Strings.past;
            repr.textBottom = hourMap[repr.hour];
        } else if (repr.minute >= 10 && repr.minute <= 20) {
            repr.textTop = Rez.Strings.quarter;
            repr.textMiddle = Rez.Strings.past;
            repr.textBottom = hourMap[repr.hour];
        } else if (repr.minute > 20 && repr.minute < 40) {
            repr.textTop = Rez.Strings.half;
            repr.textMiddle = Rez.Strings.past;
            repr.textBottom = hourMap[repr.hour];
        } else if (repr.minute >= 40 && repr.minute <= 50) {
            repr.textTop = Rez.Strings.quarter;
            repr.textMiddle = Rez.Strings.to;
            repr.textBottom = hourMap[repr.nextHour];
        } else if (repr.minute > 50 && repr.minute <= 55) {
            repr.textTop = Rez.Strings.about;
            repr.textBottom = hourMap[repr.nextHour];
        } else if (repr.minute > 55) {
            repr.hourOnTop = true;
            repr.textTop = hourMap[repr.nextHour];
            repr.textBottom =  Rez.Strings.exact;
        }

        resolveResources(repr);

        return repr;
    }

    function resolveResources(repr) {
        if (repr.textTop) {
            repr.textTop = WatchUi.loadResource(repr.textTop);
        }
        if (repr.textMiddle) {
            repr.textMiddle = WatchUi.loadResource(repr.textMiddle);
        }
        if (repr.textBottom) {
            repr.textBottom = WatchUi.loadResource(repr.textBottom);
        }
    }

}

const hourMap = {
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

const dowMap = {
    1 => Rez.Strings.dow_1,
    2 => Rez.Strings.dow_2,
    3 => Rez.Strings.dow_3,
    4 => Rez.Strings.dow_4,
    5 => Rez.Strings.dow_5,
    6 => Rez.Strings.dow_6,
    7 => Rez.Strings.dow_7,
};

const monthMap = {
    1 => Rez.Strings.mon_1,
    2 => Rez.Strings.mon_2,
    3 => Rez.Strings.mon_3,
    4 => Rez.Strings.mon_4,
    5 => Rez.Strings.mon_5,
    6 => Rez.Strings.mon_6,
    7 => Rez.Strings.mon_7,
    8 => Rez.Strings.mon_8,
    9 => Rez.Strings.mon_9,
    10 => Rez.Strings.mon_10,
    11 => Rez.Strings.mon_11,
    12 => Rez.Strings.mon_12,
};
