using Toybox.WatchUi;


class TimeEngine {
    function time() {
        var time = System.getClockTime();
        var hour = time.hour;
        var minute = time.min;
        var nextHour = hour + 1;
        if (nextHour > 23) {
            nextHour = 0;
        }

        var repr = [0, 0, 0];

        if (minute < 5) {
            repr[0] =  hour_map[hour];
            repr[2] =  Rez.Strings.exact;
        } else if (minute >= 5 && minute < 10) {
            repr[0] = Rez.Strings.some;
            repr[1] = Rez.Strings.past;
            repr[2] = hour_map[hour];
        } else if (minute >= 10 && minute <= 20) {
            repr[0] = Rez.Strings.quarter;
            repr[1] = Rez.Strings.past;
            repr[2] = hour_map[hour];
        } else if (minute > 20 && minute < 40) {
            repr[0] = Rez.Strings.half;
            repr[1] = Rez.Strings.past;
            repr[2] = hour_map[hour];
        } else if (minute >= 40 && minute <= 50) {
            repr[0] = Rez.Strings.quarter;
            repr[1] = Rez.Strings.to;
            repr[2] = hour_map[nextHour];
        } else if (minute > 50 && minute <= 55) {
            repr[0] = Rez.Strings.about;
            repr[2] = hour_map[nextHour];
        } else if (minute > 55) {
            repr[0] = hour_map[nextHour];
            repr[2] =  Rez.Strings.exact;
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