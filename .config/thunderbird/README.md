# Thunderbird setting
Copy or make a soft link to ~/.thunderbird/$PROFILE/user.js  
PROFILE=xxxxxx.default-release by default
1. Adjust font-size for Thread Pane
2. Default sorting order to descending
3. Change default browser, read more below

## Change default browser
1. Set "network.protocol-handler.warn-external.http" and "network.protocol-handler.warn-external.https" to true. 
2. Restart thunderbird and click a url. It will ask you which program to use to
   open. 
3. Find your browser, in my case a wrapper script `url_open`. 

## Some links
	https://www-archive.mozilla.org/support/thunderbird/edit
	https://support.mozilla.org/en-US/questions/1269224#answer-1282444
	user_pref("layout.css.devPixelsPerPx", "1.25");

## Ecole mail
	https://portail.polytechnique.edu/dsi/messagerie/thunderbird
