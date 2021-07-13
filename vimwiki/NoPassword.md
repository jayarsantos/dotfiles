-/etc/polkit-1/rules.d/49-nopasswd_global.rules

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

/* Allow members of the wheel group to execute any actions
 * without password authentication, similar to "sudo NOPASSWD:"
 */
polkit.addRule(function(action, subject) {
    if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

Replace wheel by any group of your preference.

Be careful with the group you choose to give such rights to.

There is also AUTH_ADMIN_KEEP which allows to keep the authorization for 5 minutes.
However, the authorization is per process, hence if a new process asks for an authorization within 5 minutes the new process will ask for the password again anyway.
