<%namespace name='library_submenu' file='_library_submenu.tpl'/>

<!doctype html>

<html lang="${request.locale}"${' dir="rtl"' if th.is_rtl(request.locale) == True else ''}>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        ## Translators, used in page title
        <title><%block name="title">Outernet</%block> - Librarian v${app_version}</title>
        <link rel="stylesheet" href="${assets['css/main']}" />
        % if not DEBUG:
        <script>
            (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
            })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
            ga('create', 'UA-47041607-2', 'auto');
            ga('send', 'pageview');
        </script>
        % endif
        <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no" />
        % if redirect_url is not UNDEFINED:
        <meta http-equiv="refresh" content="${REDIRECT_DELAY}; url=${redirect_url}" />
        % endif
        <%block name="extra_head"/>
    </head>
    <body>
        <%block name="header">
        <header class="menu">
            <div class="menu-subblock">
                <a class="logo" href="${i18n_url('content:list')}"><span lang="en">Outernet</span></a>
            </div>
            <div class="dropdown languages menu-subblock">
                <a class="dropdown-toggle" href="#"><span class="down-arrow"></span> ${th.lang_name_safe(request.locale)}</a>
                <ul class="dropdown-body">
                % for locale, lang in languages:
                    <li class="dropdown-item">
                        % if locale != request.locale:
                        <a class="language" href="${i18n_path(locale=locale)}" dir="${th.dir(locale)}" lang="${locale}">${lang}</a>
                        % else:
                        <span class="language current" dir="${th.dir(locale)}" lang="${locale}"><span class="selected"></span>${lang}</span>
                        % endif
                    </li>
                % endfor
                </ul>
            </div>
            <div class="menu-block-right">
                <nav id="nav" class="menu-subblock toolbar">
                    % for mi in menu_group('main'):
                        ${mi}
                    % endfor
                </nav>
                <div class="hamburger">
                    <a href="#nav">Site menu</a>
                </div>
            </div>
            ${library_submenu.body()}
        </header>
        </%block>

        <div class="section body">
        <%block name="main">
            <%block name="content">
                <div class="inner">
                <%block name="inner">
                    ${self.body(**context.kwargs)}
                </%block>
                </div>
            </%block>
        </%block>
        </div>

        <%block name="footer">
        <footer>
            <p class="logo"><span lang="en">Outernet</span>: ${_("Humanity's public library")}</p>
            <p class="progver" lang="en">Librarian</span> <span dir="ltr">v${app_version}</span></p>
            <p class="copyright">2014-2015 <span lang="en">Outernet Inc</span></p>
        </footer>
        </%block>

        <script type="text/template" id="menu">
            <nav class="alt-menu">
                <div class="level1" id="top">
                <a href="#alt-menu-lang" class="level2-trigger level2-trigger-lang">
                    ## Translators, appears in the mobile menu in front of language name
                    ${_('Language:')}
                    <span class="language current" dir="${th.dir(request.locale)}" lang="${request.locale}">
                        ${th.lang_name_safe(request.locale)}
                    </span>
                    <span class="level2-icon">
                    </span>
                </a>
                % for mi in menu_group('main'):
                    ${mi}
                % endfor
                <div class="submenu mobile">
                    <a class="navicon buy-a-lantern" href="http://store.outernet.is/products/lighthouse-by-outernet-satellite-data-receiver">
                        <span class="icon"></span>
                        <span class="label">${_("Buy a Lighthouse!")}</span>
                    </a>
                    <a class="navicon" href="${url('flat:how_to_connect')}">
                        <span class="icon"></span>
                        <span class="label">${_("Connect")}</span>
                    </a>
                    <a class="navicon" href="https://uplink.outernet.is/">
                        <span class="icon"></span>
                        <span class="label">${_("Uplink")}</span>
                    </a>
                    <a class="navicon" href="https://wiki.outernet.is/">
                        <span class="icon"></span>
                        <span class="label">${_("Wiki")}</span>
                    </a>
                    <a class="navicon store" href="http://store.outernet.is/">
                        <span class="icon"></span>
                        <span class="label">${_("Store")}</span>
                    </a>
                    <div class="menu-item">
                        <a class="social facebook" href="https://www.facebook.com/OuternetForAll"></a>
                        <a class="social twitter" href="https://twitter.com/outernetforall"></a>
                        <a class="social google" href="https://plus.google.com/+OuternetIs"></a>
                    </div>
                </div>
                </div>
                <div class="level2 level2-lang" id="alt-menu-lang">
                    <a class="top-trigger">${_('Back')}</a>

                    ## NOTE that this for loop is a bit different from the for
                    ## loop at the top of the document. Do not factor out into
                    ## partial template.
                    % for locale, lang in languages:
                        % if locale != request.locale:
                        <a class="language" href="${i18n_path(locale=locale)}" dir="${th.dir(locale)}" lang="${locale}">${lang}</a>
                        % else:
                        <span class="active selected" dir="${th.dir(locale)}" lang="${locale}">${lang}</span>
                        % endif
                    % endfor
                </div>
            </nav>
        </script>
        <%block name="script_templates"/>
        <script src="${assets['js/ui']}"></script>
        <%block name="extra_scripts"/>
    </body>
</html>
