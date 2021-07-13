/etc/geoclue/geoclue.conf

[redshift]
allowed=true
system=false
users=

~/.config/redshift/redshift.conf

[redshift]
temp-day=6500K
temp-night=3800
location-provider=manual

; Enable/Disable a smooth transition between day and night
; 0 will cause a direct change from day to night screen temperature.
; 1 will gradually increase or decrease the screen temperature.
transition=1
; Set the screen brightness. Default is 1.0.
;brightness=0.9
; It is also possible to use different settings for day and night
; since version 1.8.
brightness-day=1
brightness-night=0.9
; Set the screen gamma (for all colors, or each color channel
; individually)
;gamma=0.8
;gamma=0.8:0.7:0.8
; This can also be set individually for day and night since
; version 1.10.
;gamma-day=0.8:0.7:0.8
;gamma-night=0.6

[manual]
lat=17.157500
lon=121.613500
