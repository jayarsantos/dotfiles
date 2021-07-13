To lockout a user for ten minutes unlock_time=600 after three failed login attempts deny=3, add the parameters to the PAM configuration as follows:

/etc/pam.d/system-login
auth required pam_tally2.so deny=3 unlock_time=600 onerr=succeed file=/var/log/tallylog
