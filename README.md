# Visual Studio Linux Build Box

This image is used to allows Visual Studio to build a Linux application.
The official Microsoft tutorial [Visual C++ for Linux Development](https://blogs.msdn.microsoft.com/vcblog/2016/03/30/visual-c-for-linux-development/).

 ## How to use it
 ### How launch the build box

 The image expose an SSH server on port 22. The credential is:

* Login `root`
* password `toor`

So to launch the build box, execute this command on your linux docker host
 ```sh
docker run -d -p 12345:22 visual-studio-linux-build-box
 ```

### How connect to your Visual Studio

On your Visual Studio go to `Tools > Options > Cross Platform > Linux` and enter the credential

![Linux connect manager](https://msdnshared.blob.core.windows.net/media/2016/03/Connect-to-Linux-first-connection.png)

* Hostname: IP or hostname of your docker host
* Port: The port you have pass in the previous command ( `12345` for example)
* Username: `root`
* Authentication type: `password`
* Password: `toor`

## Extends

You can extends the build image to include some dependencies.

For example, the mongo-c driver

````Dockerfile

FROM visual-studio-linux-build-box

RUN apt-get update && \
    apt-get install -y libxml2-dev pkg-config libssl-dev libsasl2-dev automake autoconf libtool && \
    git clone https://github.com/mongodb/mongo-c-driver.git && \
    cd mongo-c-driver && \
    git checkout 1.3.5 && \
    ./autogen.sh && \
    make && make install

```
