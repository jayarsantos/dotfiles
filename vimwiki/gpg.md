---This is used in qutebrowser userscript qute-pass (can also be used for other purposes)

To generate password compatible with qute-pass
pass generate facebook.com/jayarsantos@gmail.com 15

the pass-structure that is used by default should look something like this:

 user@computer$ pass
 Password Store
 ├── example.site1.com
 │   └── username
 ├── example.site2.com
 │   └── username1
 │   └── username2

To access your password data in a secure way, execute the following command:
pass -c facebook.com/jayarsantos@gmail.com

If you’d like to edit your password, you can execute the following command:
pass edit facebook.com/jayarsantos@gmail.com

Insert a new password manually.
pass insert website/linkedin.com

You can view your GPG keys by executing the following:

gpg --list-keys
You’ll need to list your keys because we’ll need some information to initialize our password store. When listing your keys you’ll see something like this:

pub   rsa4096 2018-11-30 [SC]
      1A35565C9FE601446AC30BDE55238D2674A7BAD4
uid           [ultimate] Test User <test@test.com>
sub   rsa4096 2018-11-30 [E]
What is important to us is the GPG id, which in our example is the 1A35565C9FE601446AC30BDE55238D2674A7BAD4 value. By using this id value we’ll be telling the pass application that we want to use this particular key to encrypt and decrypt our passwords.

Initializing the Password Store with the CLI

With a GPG key available, we can initialize our password manager. The initialization process could use a single GPG key with a default storage path, or we can customize it to use multiple keys or even a Git repository for maintaining a history of every manipulation made to our passwords.

At a basic level, the password manager can be initialized through the following command:

pass init "GPG-ID-HERE"
When executing the above command, you’ll want to use the actual ID of your GPG key. When initializing the password store, you might be asked for your GPG passphrase as part of the validation process.

While our password manager will be empty as of now, you can list your passwords by executing the following command:

pass
The passwords will be organized by directory and file structure which we’ll see in the next step. However, the list of passwords are not encrypted as nothing within the password files are exposed, only the names themselves.
