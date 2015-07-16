<div class="introduction">
    <div class="left-sat"></div>
    <div class="right-sat"></div>
    <div class="inner">
        <h1>${_("Universal Information Access")}</h1>
        <p>
            ${_("Outernet's free satellite multicast transmits a continuous feed of digital media.")}<br />
            ${_("Our community determines which content is %(uplink_link)s for global distribution.")  % {'uplink_link': '<a href="https://uplink.outernet.is">uplinked</a>'}}<br />
            ${_("Receiving Outernet is similar to satellite tv.")}
        </p>
        <p>${_("This website represents how content displays on a satellite data receiver, <br>which you can %(buy_link)s or %(build_link)s.") % {'buy_link': '<a href="http://store.outernet.is/">buy</a>', 'build_link': '<a href="https://github.com/Outernet-Project/orx-rpi#orx-build-for-raspbery-pi">build</a>'}}</p>
        ${h.form(action=i18n_url('subscribe'), method='post', _class="subscribe")}
            ${th.csrf_tag()}
            ${h.vinput('email', {}, _type="email", _placeholder=_("Receive Updates"))}
            <button class="primary" type="submit">${_("Subscribe")}</button>
        </form>
    </div>
</div>

<script id="slider" type="text/template">
    <div class="slider-container">
        <div class="slide courseware">
            <p class="message">${_('Any digital file can be datacast over Outernet.')}</p>
        </div>
        <div class="slide usercontent">
            <p class="message">${_('Outernet is a one-way, untrackable, anonymous datacast.')}</p>
        </div>
        <div class="slide apps">
            <p class="message"><a href="http://store.outernet.is/">${_('Buy an Outernet receiver or build your own.')}</a></p>
        </div>
        <div class="slide emergencies">
            <p class="message">${_('Outernet works during disasters when terrestrial communication fails.')}</p>
        </div>
        <div class="buttons">
            <span class="icon" data-slide-name="courseware"></span>
            <span class="icon" data-slide-name="usercontent"></span>
            <span class="icon" data-slide-name="apps"></span>
            <span class="icon" data-slide-name="emergencies"></span>
        </div>
    </div>
</script>
