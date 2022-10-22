from: https://unix.stackexchange.com/questions/407447/how-to-force-a2dp-sink-when-wireless-bluetooth-headset-is-connected/415928

Switch from the HSP/HFP profile to the A2DP profile.
This will make the sound more cleaner and louder - working as of Dec 24, 2021

Edit /etc/bluetooth/main.conf.

First, add the following lines under the [General] tag (copied from audio.conf):

# Automatically connect both A2DP and HFP/HSP profiles for incoming
# connections. Some headsets that support both profiles will only connect the
# other one automatically so the default setting of true is usually a good
# idea.
AutoConnect=true

Next enable support for multiple profiles, which can be found a few lines below in main.conf:

# Enables Multi Profile Specification support. This allows to specify if
# system supports only Multiple Profiles Single Device (MPSD) configuration
# or both Multiple Profiles Single Device (MPSD) and Multiple Profiles Multiple
# Devices (MPMD) configurations.
# Possible values: "off", "single", "multiple"
MultiProfile = multiple

Additionally below config is suggested to minimize sound cutting

ControllerMode = bredr
