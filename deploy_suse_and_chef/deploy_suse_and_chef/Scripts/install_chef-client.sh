#!/bin/bash
# install_chef-client.sh
# Script is designed to build the chef-client package from source for SUSE 12
# Script is designed to run as 'root'
# USE THIS SCRIPT AT YOUR OWN RISK!
#

# Installing preprequisites and required Ruby Dependencies for the chef-client
zypper -n install bison flex libopenssl-devel libyaml-devel libffi48-devel readline-devel zlib-devel ncurses-devel sqlite3-devel gcc make wget tar gcc-c++ rpm-build unzip subversion git patch

mkdir /Downloads
cd /Downloads


# Download and install Ruby 2.2.1
wget http://cache.ruby-lang.org/pub/ruby/ruby-2.2.1.tar.gz
tar zxf ruby-2.2.1.tar.gz
cd ruby-2.2.1
./configure
make
make install

ruby -v
gem env

cd /Downloads
gem install bundler
gem install rake-compiler

# Cloning in the Chef Omnibus Repositories
git clone https://github.com/chef/omnibus-chef
git clone https://github.com/chef/omnibus-software
git clone https://github.com/chef/omnibus


# Modifying platform file to support RPMs by adding in suse entry
sed -i -e '/PLATFORM_PACKAGER_MAP = {/a\\t '\'suse\''  => RPM,' /Downloads/omnibus/lib/omnibus/packager.rb

# Modifying the bundler Gemfile to use the local repository
sed -i -e "s/gem 'omnibus', github: 'chef\/omnibus'/gem 'omnibus', path: '\/Downloads\/omnibus'/g" /Downloads/omnibus-chef/Gemfile

# Installing additional gems
cd /Downloads/omnibus-chef
bundle install --binstubs

# Modifying the omnibus-chef configuration file - turning off Amazon S3 and git caching
sed -i -e "s/use_s3_caching true/use_s3_caching false/g" /Downloads/omnibus-chef/omnibus.rb
sed -i -e "s/s3_access_key  ENV\['AWS_ACCESS_KEY_ID'\]/#s3_access_key  ENV\['AWS_ACCESS_KEY_ID'\]/g" /Downloads/omnibus-chef/omnibus.rb
sed -i -e "s/s3_secret_key  ENV\['AWS_SECRET_ACCESS_KEY'\]/#s3_secret_key  ENV\['AWS_SECRET_ACCESS_KEY'\]/g" /Downloads/omnibus-chef/omnibus.rb
sed -i -e "s/s3_bucket      'opscode-omnibus-cache'/#s3_bucket      'opscode-omnibus-cache'/g" /Downloads/omnibus-chef/omnibus.rb
sed -i -e "s/# use_git_caching false/use_git_caching false/g" /Downloads/omnibus-chef/omnibus.rb

# Copy and configure libffi.rb from omnibus-software - Step 8 in walk-through appears to be fixed as 'suse' is part of the check to move files.
cp /Downloads/omnibus-software/config/software/libffi.rb /Downloads/omnibus-chef/config/software/.

# Copy and Configure ruby.rb from omnibus-software
cp /Downloads/omnibus-software/config/software/ruby.rb /Downloads/omnibus-chef/config/software/.
sed -i -e "s/\"--disable-dtrace\"\]/\"--disable-dtrace\",/g" /Downloads/omnibus-chef/config/software/ruby.rb
sed -i -e '/\"--disable-dtrace\",/a\\t\t\t"--with-setjmp-type=_setjmp"]' /Downloads/omnibus-chef/config/software/ruby.rb

# Copy and Configure cacerts.rb from omnibus-software
cp /Downloads/omnibus-software/config/software/cacerts.rb /Downloads/omnibus-chef/config/software/.
sed -i -e "s/c9f4f7f4d6a5ef6633e893577a09865e/380df856e8f789c1af97d0da9a243769/g" /Downloads/omnibus-chef/config/software/cacerts.rb

# Adding Post Install Patch to postinst File
sed -i -e '/chown -Rh 0\:0 \$INSTALLER_DIR/a\patch -p0 << END_OF_FILE' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/patch -p0 << END_OF_FILE/a\--- /opt/chef/embedded/lib/ruby/gems/2.1.0/gems/ohai-8.4.0/lib/ohai/plugins/linux/platform.rb   2015-05-26 09:52:54.000000000 -0400' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/2015-05-26 09\:52\:54.000000000 -0400/a\+++ /opt/chef/embedded/lib/ruby/gems/2.1.0/gems/ohai-8.4.0/lib/ohai/plugins/linux/platform.rb  2015-05-26 11:17:43.510207156 -0400' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/2015-05-26 11:17:43.510207156 -0400/a\@@ -115,7 +115,7 @@' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/@@ -115,7 +115,7 @@/a\\tplatform_family "debian"' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/platform_family "debian"/a\\twhen /fedora/, /pidora/' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/when \/fedora\/, \/pidora\//a\\tplatform_family "fedora"' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/platform_family "fedora"/a\\t-    when /oracle/, /centos/, /redhat/, /scientific/, /enterpriseenterprise/, /amazon/, /xenserver/, /cloudlinux/, /ibm_powerkvm/, /parallels/' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/enterpriseenterprise/a\\t+    when /oracle/, /centos/, /redhat/, /scientific/, /enterpriseenterprise/, /amazon/, /xenserver/, /cloudlinux/, /ibm_powerkvm/, /parallels/' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/+    when/a\\tplatform_family "rhel"' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/platform_family "rhel"/a\\twhen /suse/, /base/' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/when \/suse\/, \/base\//a\\tplatform_family "suse"' /Downloads/omnibus-chef/package-scripts/chef/postinst
sed -i -e '/platform_family "suse"/a\END_OF_FILE' /Downloads/omnibus-chef/package-scripts/chef/postinst


# Creating a Stub fakeroot script so the build can run
echo '"$@"' > /usr/bin/fakeroot
chmod +x /usr/bin/fakeroot

# Running the Omnibus build to create the RPMs
bundle exec omnibus build chef --log-level=debug --override append_timestamp:false
