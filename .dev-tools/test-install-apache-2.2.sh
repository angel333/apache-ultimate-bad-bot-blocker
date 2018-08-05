#!/bin/bash
# Setup Apache for Testing the Apache Ultimate Bad Bot Blocker on apache 2.4 without mod_access_compat
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/apache-ultimate-bad-bot-blocker

##############################################################################
#        ___                 __                                              #
#       / _ | ___  ___ _____/ /  ___                                         #
#      / __ |/ _ \/ _ `/ __/ _ \/ -_)                                        #
#     /_/ |_/ .__/\_,_/\__/_//_/\__/                                         #
#        __/_/        __   ___       __     ___  __         __               #
#       / _ )___ ____/ /  / _ )___  / /_   / _ )/ /__  ____/ /_____ ____     #
#      / _  / _ `/ _  /  / _  / _ \/ __/  / _  / / _ \/ __/  '_/ -_) __/     #
#     /____/\_,_/\_,_/  /____/\___/\__/  /____/_/\___/\__/_/\_\\__/_/        #
#                                                                            #
##############################################################################

# MIT License

# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# *******************************************************
# Test Installing Apache 2.2.25
# *******************************************************

sudo apt-get remove --purge apache2
sudo apt-get install build-essential
cd /tmp

wget http://www.zlib.net/zlib-1.2.11.tar.gz
tar -xvf zlib-1.2.11.tar.gz
cd zlib-1.2.11/
./configure --prefix=/usr/local
make
sudo make install

wget https://github.com/mitchellkrogza/apache-ultimate-bad-bot-blocker/raw/master/.dev-tools/_apache_builds/httpd-2.2.25.tar.gz
tar -xvf httpd-2.2.25.tar.gz
cd httpd-2.2.25/
./configure --prefix=/usr/local/apache2 --enable-mods-shared=all --enable-deflate --enable-proxy --enable-proxy-balancer --enable-proxy-http
make
sudo make install

sudo /usr/local/apache2/bin/apachectl start

wget -qO- http://localhost | grep "It works!"

# **************************
# Show Loaded apache Modules
# **************************

printf '%s\n%s\n%s\n\n' "#################################" "Show Loaded Apache Modules" "#################################"
sudo /usr/local/apache2/bin/apachectl -M

# **************************
# Show Apache Version
# **************************

printf '%s\n%s\n%s\n\n' "#####################################" "Show Apache Version Information" "#####################################"
sudo /usr/local/apache2/bin/apachectl -V

# **********************
# Test the Apache Config
# **********************

printf '%s\n%s\n%s\n\n' "#################################" "Run Apache 2.2 Config Test" "#################################"
sudo /usr/local/apache2/bin/apachectl configtest

# Put new httpd.conf into place
echo "Copy httpd.conf"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_for_testing/apache2.2.25/httpd.conf /usr/local/apache2/conf/httpd.conf

# Get a copy of conf/extra/httpd-vhosts.conf for modification
#sudo cp /usr/local/apache2/conf/extra/httpd-vhosts.conf ${TRAVIS_BUILD_DIR}/.dev-tools/_test_results/apache2.2.25/

# Put new httpd-vhosts.conf into place
echo "Copy httpd-vhosts.conf"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_for_testing/apache2.2.25/httpd-vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf

# Restart Apache 2.2.25

echo "Restarting Apache 2.2"
sudo /usr/local/apache2/bin/apachectl restart

# Test Apache 2 Curl

wget -qO- http://local.dev

# Stop Apache 2.2.25

#echo "Stopping Apache 2.2"
#sudo /usr/local/apache2/bin/apachectl stop

# Set Apache 2.2.25 up as a service and test

#sudo cp /usr/local/apache2/bin/apachectl /etc/init.d/apache22
#sudo chmod +x /etc/init.d/apache22
#sudo service apache22 stop
#sudo service apache22 start

#sudo service apache22 configtest

# **********************
# Exit With Error Number
# **********************

exit ${?}


# MIT License

# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.