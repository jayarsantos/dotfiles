For my system there is no audit.log created in /var/log/audit
below will get the log from dmesg and write a file named a2a in home directory (in root case it is in /root
audit2allow -d -l >> ~/a2a

I personally preferred to create a directory under / called selinux-policies. For every daemon or tool I created a subfolder called for example "dmesg_t". This will help you later not to get confused. Just copy/paste this section above to a file called dmesg_t.te in the directory dmesg_t you just created. I'm sure you now will see how a policy looks like. Here you go:

-----------------------------------
/selinux-policies/policykit/policykitd.te

policy_module(policykitd,1.0.0)

require {
type policykit_t;
type init_var_run_t;
}
#============= policykit_t ==============
allow policykit_t init_var_run_t:dir read;

--------------------------------------------

root # ps -eZ | grep auditd
system_u:system_r:auditd_t      24008 ?        00:00:00 auditd

refer to the original dmesg to get the file name and the module name for the above policy
e.g dmesg | grep policykit

dmesg
This is the name of your new policy. You should give it a meaningful name to make administration easier.

1.0.0
This is the version of your policy. Everytime I change something on my policy I increase the number by 1 (For example 1.0.1)

require {
type dmesg_t;
type file_t;
}

In this section you tell SELinux which types are used in this policy. It's not that hard to figure our which types are used. Just look down in the "#========"-Section. There you see for example dmesg_t and etc_t and file_t. Guess what... These are your ty


