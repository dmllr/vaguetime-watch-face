using Toybox.WatchUi;

class TimeEngineRus {
    function time() {
        var time = System.getClockTime();
        var hour = time.hour;
        var minute = time.min;
        var nextHour = hour + 1;
        if (nextHour > 23) {
            nextHour = 0;
        }

        var repr = new TimeRepresentation();
        repr.hour = hour;
        repr.minute = minute;
        repr.hourOnTop = false;

        if (minute < 5) {
            repr.hourCase = 0;
            repr.textTop = Rez.Strings.exact;
            repr.textBottom = hourMap[hour];
        } else if (minute >= 5 && minute < 10) {
            repr.hourCase = 1;
            repr.textTop = Rez.Strings.near;
            repr.textBottom = hourMap[nextHour];
        } else if (minute >= 10 && minute <= 20) {
            repr.hourCase = 1;
            repr.textTop = Rez.Strings.quarter;
            repr.textBottom = hourMap[nextHour];
        } else if (minute > 20 && minute < 40) {
            repr.hourCase = 1;
            repr.textTop = Rez.Strings.half;
            repr.textBottom = hourMap[nextHour];
        } else if (minute >= 40 && minute <= 50) {
            repr.textTop = Rez.Strings.quarterbefore;
            repr.textBottom = hourMap[nextHour];
        } else if (minute > 50 && minute <= 55) {
            repr.textTop = Rez.Strings.about;
            repr.textBottom = hourMap[nextHour];
        } else if (minute > 55) {
            repr.textTop = Rez.Strings.exact;
            repr.textBottom = hourMap[nextHour];
        }

        return repr;
    }

}