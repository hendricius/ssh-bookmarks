# SSH Bookmarks
Solves the problem of having to remember tons of ssh user names/hosts. Store
your connections as YAML bookmarks. Open the bookmarks via your command line.

![Bookmarks example](http://i.imgur.com/Tfug9q3.png)

# Getting started

    cp bookmarks.example.yml bookmarks.yml

Modify the bookmarks.yml file with your bookmarks.

    ruby ssh_bookmarks.rb

For easier use, create a shell alias:

    alias sshm="ruby /Users/hendricius/code/ssh-bookmarks/ssh_bookmarks.rb"
