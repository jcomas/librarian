/*jslint browser: true*/
(function ($) {
    'use strict';
    var delay = 3000,  // slide change delay in milliseconds
        intro = $('.introduction .inner'),
        slider = $(window.templates.slider);

    function deactivateAll() {
        $('.buttons .icon').removeClass('active');
        $('.slide').removeClass('visible');
    }

    function activate(button) {
        var slideName = button.data('slide-name');
        deactivateAll();
        $('.slide.' + slideName).addClass('visible');
        $('.buttons .icon[data-slide-name="{0}"]'.replace('{0}', slideName)).addClass('active');
    }

    $('.buttons .icon').on('click', function () {
        var button = $(this);

        if (!button.hasClass('active')) {
            activate(button);
        }
    });

    function startSlide() {
        var nextButton = $('.buttons .icon.active').next();

        if (nextButton.length === 0) {
            nextButton = $('.buttons .icon').first();
        }
        activate(nextButton);
        setTimeout(startSlide, delay);
    }

    intro.append(slider);
    startSlide();
}(this.jQuery));
