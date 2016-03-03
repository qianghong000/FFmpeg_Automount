#!/bin/bash
cp -rf ffmpeg_sources /usr/local/
dir_home=/usr/local/ffmpeg_sources
dir_fdk_aac=$dir_home/"fdk-aac-0.1.4"
dir_ffmpeg=$dir_home/"ffmpeg-2.2.3"
dir_lame=$dir_home/"lame-3.99.5"
dir_libogg=$dir_home/"libogg-1.3.2"
dir_libvorbis=$dir_home/"libvorbis-1.3.5"
dir_libvpx=$dir_home/"libvpx-v1.1.0"
dir_opus=$dir_home/"opus-1.1.1"
dir_x264=$dir_home/x264
dir_yasm=$dir_home/"yasm-1.3.0"
chmod +x -R $dir_home
 
### Get the Dependencies ############
yum -y install automake autoconf make gcc gcc-c++ libtool zlib zlib-devel curl curl-devel alsa-lib alsa-lib-devel gettext gettext-devel expat expat-devel patch perl-ExtUtils-MakeMaker doxygen unzip git
if [ $? -eq 0 ];then
    echo "dependencis install SUCCESSFUL!" >> $dir_home/ffmpeg_install.log
else
    echo "dependencis install FAILD!" >> $dir_home/ffmpeg_install.log
    exit
fi
 
### Compilation & Installation
######## Yasm ############
cd $dir_home
tar xzvf yasm-1.3.0.tar.gz
if [ -d $dir_yasm ];then
    echo "$dir_yasm is exist!" >> $dir_home/ffmpeg_install.log
    cd $dir_yasm
    ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
    if [ $? -eq 0 ];then
        echo "configure successful!" >> $dir_home/ffmpeg_install.log
        make &&make install &&make distclean &&. ~/.bash_profile
	echo "yasm installed SUCCESSFUL!" >> $dir_home/ffmpeg_install.log
    else
        echo "configure faild!" >> $dir_home/ffmpeg_install.log
        exit
    fi
else
    echo "$dir_yasm is not exist!" >> $dir_home/ffmpeg_install.log
    exit
fi
######### x264 ##########
cd $dir_home
tar zxvf x264.tar.gz
if [ -d $dir_x264 ];then
    echo "$dir_x264 is exist!" >> $dir_home/ffmpeg_install.log
    cd $dir_x264
    ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static 
    if [ $? -eq 0 ];then
        echo "configure successful!" >> $dir_home/ffmpeg_install.log
        make && make install && make distclean 
	echo "x264 installed SUCCESSFUL!" >> $dir_home/ffmpeg_install.log
    else
        echo "configure faild!" >> $dir_home/ffmpeg_install.log
        exit
    fi
else
    echo "$dir_x264 is not exist!" >> $dir_home/ffmpeg_install.log
    exit
fi
########## libfdk_aac #########
cd $dir_home
tar zxvf fdk-aac-0.1.4.tar.gz
if [ -d $dir_fdk_aac ];then
    echo "$dir_fdk_aac is exist!" >> $dir_home/ffmpeg_install.log
    cd $dir_fdk_aac
    autoreconf -fiv 
    ./configure --prefix="$HOME/ffmpeg_build" --disable-shared 
    if [ $? -eq 0 ];then
        echo "configure successful!" >> $dir_home/ffmpeg_install.log 
        make && make install && make distclean 
	echo "libfdk_aac installed SUCCESSFUL!" >> $dir_home/ffmpeg_install.log
    else
        echo "configure faild!" >> $dir_home/ffmpeg_install.log
        exit
    fi
else
    echo "$dir_fdk_aac is not exist!" >> $dir_home/ffmpeg_install.log
    exit
fi
######### libmp3lame #########
cd $dir_home
tar zxvf lame-3.99.5.tar.gz
if [ -d $dir_lame ];then
    echo "$dir_lame is exist!" >> $dir_home/ffmpeg_install.log
    cd $dir_lame
    ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --disable-shared --enable-nasm
    if [ $? -eq 0 ];then
        echo "configure successful!" >> $dir_home/ffmpeg_install.log
        make && make install && make distclean
	echo "lame installed SUCCESSFUL!" >> $dir_home/ffmpeg_install.log
    else
        echo "configure faild!" >> $dir_home/ffmpeg_install.log
        exit
    fi
else
        echo "$dir_lame is not exist!" >> $dir_home/ffmpeg_install.log
        exit
fi
 
########### libopus ############
cd $dir_home
tar zxvf opus-1.1.1.tar.gz
if [ -d $dir_opus ];then
    echo "$dir_opus is exist!" >> $dir_home/ffmpeg_install.log
    cd $dir_opus
    ./configure --prefix="$HOME/ffmpeg_build" --disable-shared 
    if [ $? -eq 0 ];then
        echo "configure successful!" >> $dir_home/ffmpeg_install.log
        make && make install && make distclean 
	echo "libopus installed SUCCESSFUL!" >> $dir_home/ffmpeg_install.log
    else
        echo "configure faild!" >> $dir_home/ffmpeg_install.log
        exit
    fi
else
    echo "$dir_opus is not exist!" >> $dir_home/ffmpeg_install.log
    exit
fi
### libogg #######
cd $dir_home
tar zxvf libogg-1.3.2.tar.gz
if [ -d $dir_libogg ];then
    echo "$dir_libogg is exist!" >> $dir_home/ffmpeg_install.log
    cd $dir_libogg
    ./configure --prefix="$HOME/ffmpeg_build" --disable-shared 
    if [ $? -eq 0 ];then
        echo "configure successful!" >> $dir_home/ffmpeg_install.log
        make && make install && make distclean
	echo "libogg installed SUCCESSFUL!" >> $dir_home/ffmpeg_install.log
    else
        echo "configure faild!" >> $dir_home/ffmpeg_install.log
        exit
    fi
else
    echo "$dir_libogg is not exist!" >> $dir_home/ffmpeg_install.log
    exit
fi
######### libvorbis #####
cd $dir_home
tar xvfz libvorbis-1.3.5.tar.gz
if [ -d $dir_libvorbis ];then
    echo "$dir_libvorbis is exist!" >> $dir_home/ffmpeg_install.log
    cd $dir_libvorbis
    ./configure --prefix="$HOME/ffmpeg_build" --with-ogg="$HOME/ffmpeg_build" --disable-shared 
    if [ $? -eq 0 ];then
        echo "configure successful!" >> $dir_home/ffmpeg_install.log
        make && make install && make distclean 
	echo "libvorbis installed SUCCESSFUL!" >> $dir_home/ffmpeg_install.log
    else
        echo "configure faild!" >> $dir_home/ffmpeg_install.log
        exit
    fi
else
    echo "$dir_libvorbis is not exist!" >> $dir_home/ffmpeg_install.log
    exit
fi
############### libvpx ################
cd $dir_home
tar jxvf libvpx-v1.1.0.tar.bz2
if [ -d $dir_libvpx ];then
    echo "$dir_libvpx is exist!" >> $dir_home/ffmpeg_install.log
    cd $dir_libvpx
    ./configure --prefix="$HOME/ffmpeg_build" --disable-examples 
    if [ $? -eq 0 ];then
        echo "configure successful!" >> $dir_home/ffmpeg_install.log 
        make && make install && make clean
	echo "libvpx installed SUCCESSFUL!" >> $dir_home/ffmpeg_install.log
    else
        echo "configure faild!" >> $dir_home/ffmpeg_install.log
        exit
    fi
else
    echo "$dir_libvpx is not exist!" >> $dir_home/ffmpeg_install.log
    exit
fi
###### FFmpeg #########
cd $dir_home
tar zxvf ffmpeg-2.2.3.tar.gz
if [ -d $dir_ffmpeg ];then
    echo "$dir_ffmpeg is exist!" >> $dir_home/ffmpeg_install.log
    cd $dir_ffmpeg
    PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig"
    export PKG_CONFIG_PATH 
    ./configure --prefix="$HOME/ffmpeg_build" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="$HOME/bin" --extra-libs="-ldl" --enable-gpl --enable-nonfree --enable-libfdk_aac --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 
    if [ $? -eq 0 ];then
        echo "configure successful!" >> $dir_home/ffmpeg_install.log
        make &&make install &&make distclean &&hash -r &&. ~/.bash_profile         
		echo "ffmpeg installed SUCCESSFUL!" >>$dir_home/ffmpeg_install.log
    else
        echo "configure faild!" >> $dir_home/ffmpeg_install.log
        exit
    fi
else
    echo "$dir_ffmpeg is not exist!" >> $dir_home/ffmpeg_install.log
    exit
fi
