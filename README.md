# NVIDIA DOCKER SOP

## First, Install cuda 9.0
<pre><code>$ wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb
</code></pre>
Enter tty mode (Alt + Ctrl + F1)
<pre><code>$ sudo apt-get remove --purge nvidia*
$ sudo service lightdm stop
</code></pre>
Blacklist nouveau

<pre><code>$ blacklist nouveau
$ blacklist lbm-nouveau
$ options nouveau modeset=0
$ alias nouveau off
$ alias lbm-nouveau off
$ echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf build the new kernel by:
$ sudo update-initramfs -u
$ reboot
$ dpkg -i cuda.deb
$ sudo apt-get update
$ sudo apt-get install cuda
$ reboot</code></pre>
## Second, Install cudnn 7.0

<pre><code>$ wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/9.0_20171129/Ubuntu16_04-x64/libcudnn7_7.0.5.15-1+cuda9.0_amd64
$ sudo dpkg -i cudnn.deb</code></pre>
## Third, Install docker

Older versions of Docker were called docker or docker-engine. If these are installed, uninstall them:
<pre><code>$ sudo apt-get remove docker docker-engine docker.io
$ sudo apt-get update</code></pre>
Install packages to allow apt to use a repository over HTTPS:
<pre><code>$ sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
$ sudo apt-get update
</code></pre>
Install docker-ce 18.03.1
<pre><code>$ sudo apt-get install docker-ce=18.03.1ce-0ubuntu</code></pre>

set up the docker repository.
<pre><code>$ curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | 
$ sudo apt-key add - distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
$ curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | 
$ sudo tee /etc/apt/sources.list.d/nvidia-docker.list</code></pre>
Update the apt package index.
<pre><code>$ sudo apt-get update</code></pre>

Install nvidia-docker2 and reload docker daemon configuration
<pre><code>$ sudo apt-get install -y nvidia-docker2
$ sudo pkill -SIGHUP dockerd</code></pre>

Edit daemon configuration file
<pre><code>$ vim /etc/docker/daemon.json</pre></code>
<code>
{
  "runtimes": {
    "nvidia": {
    "path": "/usr/bin/nvidia-container-runtime",
    "runtimeArgs": []
    }
  }
}</code></pre>

Edit to

<pre><code>{
 **"default-runtime": "nvidia"**
    "runtimes": {
    "nvidia": {
    "path": "/usr/bin/nvidia-container-runtime",
    "runtimeArgs": []
    }
  }
}</code></pre>

<pre><code>$ sudo systemctl restart docker
$ systemctl status docker</code></pre>
Verify that Docker CE is installed correctly by running the hello-world image.
<pre><code>$ sudo docker run hello-world</code></pre>

Reference: 
https://docs.docker.com/install/linux/docker-ce/ubuntu/#upgrade-docker-after-using-the-convenience-script
https://kairen.github.io/2018/02/17/container/docker-nvidia-install/
https://medium.com/@wrre/%E5%9C%A8ubuntu%E5%AE%89%E8%A3%9Ddocker%E5%8F%8Anvidia-docker-a35c1994d51e
https://blog.gtwang.org/virtualization/ubuntu-linux-install-docker-tutorial/

# Use Docker in Pycharm

## First, Using docker with cv2.show

*Run → Edit configuration → Templates → Python*

Setting the mapping disk by volume bindings

Set /tmp/.X11-unix as container path and host path

Set environment variables
<pre><code>QT_X11_NO_MITSHM : 1
DISPLAY: please echo $DISPLAY, the fill in the return value
</code></pre>

## Second, Set the interpreter.
1. Set interpreter path as python3.6



