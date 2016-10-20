$(document).ready(function(event) {
    function menu_set_width(value) {
        $('section.wy-nav-content-wrap').css('margin-left', value + 'px');
        $('nav.wy-nav-side .wy-side-scroll').css('width', (value + 20) + 'px');

        $('nav.wy-nav-side,' +
          'nav.wy-nav-side .wy-side-nav-search,' +
          'nav.wy-nav-side .wy-side-nav-search,' +
          'nav.wy-nav-side .wy-menu-vertical'
        ).css('width', value + 'px');

    }

    function menu_resize_width(value) {
        menu_set_width($('nav.wy-nav-side').width() + value);
    }

    function update_settings() {
        document.cookie = 'settings=' + JSON.stringify({
            no_menu: $('body').hasClass('no-menu'),
            full_screen: $('body').hasClass('full-screen'),
            menu_width: $('nav.wy-nav-side').width(),
        });
    }

	function load_settings() {
		$.each(document.cookie.split(';'), function(index, cookie) {
            if(cookie.startsWith('settings=')) {
                var settings = JSON.parse(cookie.substring(9));

                if(settings.no_menu) {
                    $('body').addClass('no-menu');
                }

                if(settings.full_screen) {
                    $('body').addClass('full-screen');
                }

                menu_set_width(settings.menu_width);
            }
        });
	}

    $('<li class="toggle" id="no-menu">' +
          '<span class="fa-stack toggle no-menu">' +
              '<i class="fa fa-bars fa-stack-1x"></i>' +
              '<i class="fa fa-ban fa-stack-2x"></i>' +
          '</span> | ' +
      '</li>'
    ).prependTo('[role="navigation"] .wy-breadcrumbs');

    $('<li class="wy-breadcrumbs-aside toggle" id="full-screen">' +
          ' | <span class="fa-stack">' +
              '<i class="fa fa-expand"></i>' +
              '<i class="fa fa-compress"></i>' +
          '</span>' +
      '</li>'
    ).insertBefore('[role="navigation"] .wy-breadcrumbs-aside');

    $('<div id="menu-resize">' +
          '<i class="fa fa-minus-circle"></i>' +
          '<i class="fa fa-circle-o"></i>' +
          '<i class="fa fa-plus-circle"></i>' +
      '</div>'
    ).prependTo('nav.wy-nav-side');

    $('.toggle#no-menu').click(function(event) {
        $('body').toggleClass('no-menu');
        update_settings();
    });

    $('.toggle#full-screen').click(function(event) {
        $('body').toggleClass('full-screen');
        update_settings();
    });

    $('#menu-resize .fa-minus-circle').click(function(event) {
        menu_resize_width(-5);
        update_settings();
    });

    $('#menu-resize .fa-circle-o').click(function(event) {
        menu_set_width(300);
        update_settings();
    });

    $('#menu-resize .fa-plus-circle').click(function(event) {
        menu_resize_width(5);
        update_settings();
    });

    load_settings();
});
