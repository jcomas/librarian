<div class="introduction">
    <div class="left-sat"></div>
    <div class="right-sat"></div>
    <div class="inner">
        <h1>${_("Free data everywhere on Earth without an Internet connection")}</h1>
        <p>${_("""
        Outernet datacasts the best content from the web. There is no cost to receive
        the Outernet datacast and setting up a receiver is
        <a href="%(url)s">simple</a>. Since 60%% of humanity cannot access the
        Internet, Outernet provides a new way to receive the digital media the rest
        of us enjoy everyday.
        """) % {'url': i18n_url('flat:how_to_connect')}}
        </p>

        <p>
        ${_("""
        Outernet selects content that we believe will benefit humanity, but most of
        what is datacast is chosen by you.
        <a href="https://broadcast.outernet.is/">Add your own content</a>
        or <a href="https://wiki.outernet.is/">help us decide</a> what we curate.
        """)}
        </p>
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
