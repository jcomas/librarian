<%inherit file="_dashboard_section.tpl"/>

## Translators, used as note in Application network interfaces section
<p>${_('List of available network interfaces')}</p>
<table class="network-interfaces">
    <tr>
        ## Translators, used as label for network interface name
        <th>${_('Interface name')}</th>
        <th>${'IPv4'}</th>
        <th>${'IPv6'}</th>
        ## Translators, used as label for network interface type
        <th>${_('Interface type')}</th>
    </tr>
    % for iface in interfaces:
    <tr>
        <td>${iface.name}</td>
        <td>${iface.ipv4}</td>
        <td>${iface.ipv6}</td>
        <%
        if iface.is_ethernet:
            interface_type = 'ethernet'
        elif iface.is_wireless:
            interface_type = 'wireless'
        else:
            interface_type = 'loopback'
        %>
        <td><span class="icon ${interface_type}"></span></td>
    </tr>
    % endfor
</table>