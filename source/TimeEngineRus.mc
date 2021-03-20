using Toybox.WatchUi;

class TimeEngineRus extends TimeEngine {

    function initialize() {
        TimeEngine.initialize();
    }

    function time() {
        var repr = timeRepr();

        if (repr.minute < 5) {
            repr.hourCase = 0;
            repr.textTop = Rez.Strings.exact;
            repr.textBottom = hourMap[repr.hour];
        } else if (repr.minute >= 5 && repr.minute < 10) {
            repr.hourCase = 1;
            repr.textTop = Rez.Strings.near;
            repr.textBottom = hourMap[repr.nextHour];
        } else if (repr.minute >= 10 && repr.minute <= 20) {
            repr.hourCase = 1;
            repr.textTop = Rez.Strings.quarter;
            repr.textBottom = hourMap[repr.nextHour];
        } else if (repr.minute > 20 && repr.minute < 40) {
            repr.hourCase = 1;
            repr.textTop = Rez.Strings.half;
            repr.textBottom = hourMap[repr.nextHour];
        } else if (repr.minute >= 40 && repr.minute <= 50) {
            repr.textTop = Rez.Strings.quarterbefore;
            repr.textBottom = hourMap[repr.nextHour];
        } else if (repr.minute > 50 && repr.minute <= 55) {
            repr.textTop = Rez.Strings.about;
            repr.textBottom = hourMap[repr.nextHour];
        } else if (repr.minute > 55) {
            repr.textTop = Rez.Strings.exact;
            repr.textBottom = hourMap[repr.nextHour];
        }

        resolveResources(repr);

        return repr;
    }

    function resolveResources(repr) {
        if (repr.textTop) {
            repr.textTop = revealCase(WatchUi.loadResource(repr.textTop), repr);
        }
        if (repr.textBottom) {
            repr.textBottom = revealCase(WatchUi.loadResource(repr.textBottom), repr);
        }
    }

    static function revealCase(text, repr) {
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
}