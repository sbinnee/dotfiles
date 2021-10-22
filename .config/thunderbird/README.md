# Thunderbird setting
Copy or make a soft link to ~/.thunderbird/$PROFILE/user.js
PROFILE=xxxxxx.default-release by default
1. Adjust font-size for Thread Pane
2. Default sorting order to descending
3. Change default browser, read more below

## Storage
Turn off sync in Account setting and delect files inside $PROFILE. Look for IMAP
something something folder.

[link](http://kb.mozillazine.org/Minimize_the_size_of_a_profile)

## Change default browser
Read arch wiki thunderbird page
1. Set "network.protocol-handler.warn-external.http" and "network.protocol-handler.warn-external.https" to true.
2. Restart thunderbird and click a url. It will ask you which program to use to
   open.
3. Find your browser, in my case a wrapper script `url_open`.
4. This setting will be written in $PROFILE/handlers.json

## Some links
    https://www-archive.mozilla.org/support/thunderbird/edit
    https://support.mozilla.org/en-US/questions/1269224#answer-1282444
    user_pref("layout.css.devPixelsPerPx", "1.25");

## Ecole mail
LDAP setup

1. Address book -> File -> New -> LDAP directory
2. Fill in
    name: whatever
    hostname: ldap-lab.polytechnique.fr
    base DN: ou=Utilisateurs,dc=id,dc=polytechnique,dc=edu
    port number: 389
3. Account setting -> Composition & Addressing
4. Use a differenct LDAP server

    https://portail.polytechnique.edu/dsi/messagerie/thunderbird
