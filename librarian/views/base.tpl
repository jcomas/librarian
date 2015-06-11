<!doctype html>

<html lang="${request.locale}"${' dir="rtl"' if th.is_rtl(request.locale) == True else ''}>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        ## Translators, used in page title
        <title><%block name="title">Outernet</%block> :: ${_('Librarian')} v${app_version}</title>
        <link rel="stylesheet" href="${assets['css/main']}" />
        <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no" />
        % if redirect is not UNDEFINED:
        <meta http-equiv="refresh" content="5; url=${redirect}" />
        % endif
        <%block name="extra_head"/>
    </head>
    <body>
        <%block name="header">
        <header class="menu">
            <div class="logo">OUTERNET</div>
            <div class="dropdown languages">
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
            <nav id="toolbar" class="menu-block-right toolbar">
                <% icon = '<span class="icon"></span>' %>
                ## Translators, used main navigation menu
                ${h.link_other(_('Library'), i18n_url('content:list'), request.original_path, h.SPAN, _class="archive navicon")}
                ## Translators, used main navigation menu
                ${h.link_other(_('Files'), i18n_url('files:list'), request.original_path, h.SPAN, _class="files navicon")}
                ## Translators, used main navigation menu
                ${h.link_other(_('Sites'), i18n_url('content:sites_list'), request.original_path, h.SPAN, _class="sites navicon")}
                ## Translators, used main navigation menu
                ${h.link_other(_('Apps'), i18n_url('apps:list'), request.original_path, h.SPAN, _class="apps navicon")}
                ## Translators, used main navigation menu
                ${h.link_other(_('Updates') + (' (%s)' % th.updates() if th.updates() > 0 else ''), i18n_url('downloads:list'), i18n_path(request.path), h.SPAN, _class="updates navicon" + (th.updates() > 0 and ' notice' or ''))}
                ## Translators, used main navigation menu
                ${h.link_other(_('Dashboard'), i18n_url('dashboard:main'), request.original_path, h.SPAN, _class="dashboard navicon")}
                ## Translators, used main navigation menu
                % if hasattr(request, 'user') and request.user.is_authenticated:
                ${h.link_other(icon + _('Log out'), i18n_url('auth:logout') + '?next=' + request.fullpath, request.original_path, h.SPAN, _class="exit navicon")}
                % endif
            </nav>
        </header>
        </%block>

        <div class="section body">
        <%block name="main">
            <h1><%block name="heading"/></h1>
            <%block name="content">
                <div class="inner">
                <%block name="inner">
                    ${self.body(**context.kwargs)}
                </%block>
                </div>
            </%block>
        </%block>
        </div>

        <div class="footer">
        <p class="logo"><img src="${th.static_url('sys:static', path='img/outernet_logo.png')}" alt="Outernet: Humanity's Public Library"></p>
        ## Translators, used in footer
        <p class="appver">${_('Librarian')} v${app_version}</p>
        <p class="copy">2014 Outernet Inc</p>
        </div>

        <%block name="script_templates"/>
        <script src="${assets['js/ui']}"></script>
        <%block name="extra_scripts"/>
    </body>
</html>
