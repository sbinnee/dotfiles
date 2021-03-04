// Mozilla User Preferences

user_pref("browser.fullscreen.autohide", false);

// Scrolling
user_pref("mousewheel.default.delta_multiplier_y", 50);
user_pref("mousewheel.default.delta_multiplier_x", 300);
user_pref("mousewheel.transaction.ignoremovedelay", 16);
user_pref("mousewheel.min_line_scroll_amount", 1);
user_pref("general.smoothScroll.mouseWheel.durationMinMS", 10);
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 50);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 100);
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 100);

// Hardware acceleration
// Don't forget to set ENV variable!
user_pref("layers.acceleration.force-enabled", true);
user_pref("gfx.webrender.all", true);
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.ffmpeg.vaapi-drm-display.enabled", true);
user_pref("media.ffvpx.enabled", true);
user_pref("media.av1.enabled", false);

// Right mouse click
// https://wiki.archlinux.org/index.php/Firefox#Right_mouse_button_instantly_clicks_the_first_option_in_window_managers
user_pref("ui.context_menus.after_mouseup", true);
user_pref("full-screen-api.ignore-widgets", true);
