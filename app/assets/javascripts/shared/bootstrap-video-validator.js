(function($) {
    $.fn.bootstrapValidator.validators.videoProvider = {
        validate: function(validator, $field, options) {
            var value = $field.val();
            var regYoutube = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
            var regVimeo = /^.*(vimeo\.com\/)((channels\/[A-z]+\/)|(groups\/[A-z]+\/videos\/))?([0-9]+)/;
            var regDailymotion = /^.+dailymotion.com\/(video|hub)\/([^_]+)[^#]*(#video=([^_&]+))?/;

            return regYoutube.test(value) || regDailymotion.test(value) || regVimeo.test(value);
        }
    };
}(window.jQuery));
