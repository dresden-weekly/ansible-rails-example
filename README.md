ansible-rails-example
=====================

This project contains some example usages of the [ansible-rails](https://github.com/dresden-weekly/ansible-rails) roles.

Requirements
------------

* Vagrant with VirtualBox
* A shell that can run Windows 7 batch files or Bash shell scripts
* A working internet connection

Basic Usage
-----------

1. Clone this repository
   ```bash
   git clone https://github.com/dresden-weekly/ansible-rails-example --recurse-submodules
   ```
1. Create an SSH identity RSA key pair
   1. Copy the public key to `ansible/id_rsa.pub`
   1. Add the created key and the vagrant keys to your ssh_agent
   1. For Windows you might want to use [ssh-pageant](https://github.com/cuviper/ssh-pageant)
1. Run the `remote.bat` or `remote.sh` *this might take a while*
1. Open http://127.0.0.1:8081 in your browser

Advanced Usage
--------------

These examples are meant as starting points for your own projects.
Feel free to combine your roles with ours.

**Please consider open sourcing generic roles or ideas**

Branches
--------

We use different branches to check and show verious flavors of Rails deployment.

* [simple](https://github.com/dresden-weekly/ansible-rails-example/tree/simple) a single server that hosts database, webserver and application
* [threetier](https://github.com/dresden-weekly/ansible-rails-example/tree/threetier) database, webserver and application on separate machines

Releases
--------

The first two digits correspond to [ansible-rails releases](https://github.com/dresden-weekly/ansible-rails/releases) followed by the branch name and possible a patch release.

License
-------

The MIT License (MIT)

Copyright (c) 2015 dresden-weekly

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
