Using this vimrc
================
Although a vimrc is a very personal thing, you may use mine if you
like it.  To do so, please do the following:

1. Clone this repo::

   	git clone git://github.com/nvie/vimrc.git

   or download the plain source only::

   	wget -qO - http://github.com/nvie/vimrc/tarball/master | tar -xzvf -

2. In your ~/.vimrc, add the following line::

   	source ~/path/to/vimrc/vimrc

3. To use the Vim macro's that use the project folder detection script,
   add it to your PATH::

   	PATH=$PATH:~/.vim/bin

4. Fetch submodules::

   	git submodule init
   	git submodule update

5. Recompile Command-T Ruby C extension for your platform (if other than
   Mac OS X)::

   	cd vim/ruby/command-t
   	ruby extconf.rb
   	make clean; make

That's it.
