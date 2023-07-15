/////////////////////////////////////////
// ARKENFOX OVERRIDES                  //
// https://github.com/arkenfox/user.js //
/////////////////////////////////////////

user_pref("browser.startup.page", 3); // 0102
user_pref("privacy.clearOnShutdown.history", false); // 2811
user_pref("privacy.resistFingerprinting.letterboxing", false); // 4504
user_pref("signon.rememberSignons", false); // 5003
user_pref("keyword.enabled", true); // 0801

////////////////////
// MY OWN SETTIGS //
////////////////////

// Toolbar (Right Click) > Bookmarks Toolbar > Only Show on New Tab
user_pref("browser.toolbars.bookmarks.visibility", "newtab");

// Find toolbar > Highlight All
user_pref("findbar.highlightAll", true);

// Tabs > Ctrl+Tab cycles through tabs in recently used order
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);

// Browsing > Use autoscrolling
user_pref("general.autoScroll", true);
user_pref("middlemouse.paste", false);

// Minimal tab width
user_pref("browser.tabs.tabMinWidth", 100);

// Dark theme for the PDF viewer
user_pref("pdfjs.viewerCssTheme", 2);
