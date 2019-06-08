# Install cmake
sudo apt install build-essential cmake unzip pkg-config

# Install some OpenCV-specific prerequisites
sudo apt install libjpeg-dev libpng-dev libtiff-dev

# Install video I/O packages 
sudo apt install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt install libxvidcore-dev libx264-dev

# Install GTK 
sudo apt install libgtk-3-dev

# Libraries for Optimizing OpenCV 
sudo apt install libatlas-base-dev gfortran

# Install Python3 
sudo apt install python3-dev

# Download official OpenCV Source and unzip it
cd ~
OPENCV_ZIP="opencv.zip"
if [ -f "$OPENCV_ZIP" ]
then
    echo "$OPENCV_ZIP found."
else 
    wget -O opencv.zip https://github.com/opencv/opencv/archive/4.1.0.zip
fi

OPENCV_CONTRIB_ZIP="opencv_contrib.zip"
if [ -f "$OPENCV_CONTRIB_ZIP" ]
then
	echo "$OPENCV_CONTRIB_ZIP found."
else
	wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.1.0.zip
fi

OPENCV="opencv/"
if [ -e "$OPENCV" ]
then
    echo "$OPENCV found."
else 
    unzip opencv.zip
    mv opencv-4.1.0 opencv
fi

OPENCV_CONTRIB="opencv_contrib/"
if [ -e "$OPENCV_CONTRIB" ]
then
    echo "$OPENCV_CONTRIB found."
else 
    unzip opencv_contrib.zip
    mv opencv_contrib-4.1.0 opencv_contrib
fi

# Configure your Python 3 environment
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
pip3 install numpy

# Configure OpenCV with CMake and build opencv 
cd ~/opencv 
mkdir build
cd build 

cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D INSTALL_C_EXAMPLES=OFF \
	-D OPENCV_ENABLE_NONFREE=ON \
	-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
	-D PYTHON_EXECUTABLE=~/usr/bin/python3 \
	-D BUILD_EXAMPLES=ON ..

make -j4
sudo make install
sudo ldconfig


