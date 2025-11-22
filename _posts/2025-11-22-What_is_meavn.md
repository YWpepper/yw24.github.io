---
layout: post
title: 'What_is_Meavn'
date: 2025-11-22
author: pepper
tags: [error]
comments: true
toc: true
pinned: false
---


### Meavn管理
[参考知乎](https://zhuanlan.zhihu.com/p/623082998)

#### 多模块项目的创建
Maven支持将一个大型项目分成多个子模块，每个子模块可以有自己的pom.xml文件、源代码和依赖库等信息。

1. Parent多模块项目的创建

创建**一个多模块项目**可以采用如下的命令：

```bash
mvn archetype:generate -DgroupId=com.mycompany.app 
-DartifactId=my-app-parent 
-DarchetypeGroupId=org.apache.maven.archetypes 
-DinteractiveMode=false
```

其中，-DgroupId指定项目的groupId，-DartifactId指定项目的artifactId，-DarchetypeGroupId指定使用的Maven原型。

执行以上命令后，Maven会在当前目录下生成一个名为my-app-parent的项目，作为多模块项目的父项目。

2. Son子模块的创建

在**多模块项目**中**创建子模块**可以采用如下的命令：

```bash
mvn archetype:generate -DgroupId=com.mycompany.app  
-DartifactId=my-app-webapp 
-DarchetypeGroupId=org.apache.maven.archetypes 
-DinteractiveMode=false
```

其中，-DgroupId指定项目的groupId，-DartifactId指定项目的artifactId，-DarchetypeGroupId指定使用的Maven原型。

执行以上命令后，Maven会在当前目录下生成一个名为`my-app-webapp`的子模块项目，并将其作为`my-app-parent`的子模块。

> PS:  报错，当我运行完上述第一条创建父类的指令之后，我运行son指令的时候出现了报错如下
>

```bash
(base) root@DESKTOP-GTJ6F35:my-app-parent# mvn archetype:generate -DgroupId=com.mycompany.app  -DartifactId=my-app-webapp -DarchetypeGroupId=org.apache.maven.archetypes -DinteractiveMode=false
[INFO] Scanning for projects...
[INFO] 
[INFO] ------------------< com.mycompany.app:my-app-parent >-------------------
[INFO] Building my-app-parent 1.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] >>> maven-archetype-plugin:3.4.1:generate (default-cli) > generate-sources @ my-app-parent >>>
[INFO] 
[INFO] <<< maven-archetype-plugin:3.4.1:generate (default-cli) < generate-sources @ my-app-parent <<<
[INFO] 
[INFO] 
[INFO] --- maven-archetype-plugin:3.4.1:generate (default-cli) @ my-app-parent ---
[INFO] Generating project in Batch mode
[INFO] No archetype defined. Using maven-archetype-quickstart (org.apache.maven.archetypes:maven-archetype-quickstart:1.0)
[INFO] ----------------------------------------------------------------------------
[INFO] Using following parameters for creating project from Old (1.x) Archetype: maven-archetype-quickstart:1.0
[INFO] ----------------------------------------------------------------------------
[INFO] Parameter: basedir, Value: /root/tiger/ByFunction/Java/myTest/my-app-parent
[INFO] Parameter: package, Value: com.mycompany.app
[INFO] Parameter: groupId, Value: com.mycompany.app
[INFO] Parameter: artifactId, Value: my-app-webapp
[INFO] Parameter: packageName, Value: com.mycompany.app
[INFO] Parameter: version, Value: 1.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.678 s
[INFO] Finished at: 2025-11-20T10:55:41+08:00
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-archetype-plugin:3.4.1:generate (default-cli) on project my-app-parent: Unable to add module to the current project as it is not of packaging type 'pom' -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoExecutionException
```

分析： 

我已经指定了路径：`/root/tiger/ByFunction/Java/myTest/my-app-parent`，我已经进入到了父类里面来创建子类，总结最后的报错是 `Unable to add module to the current project as it is not of packaging type 'pom' `。

解析：

修改pom.xml配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?><project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app-parent</artifactId>
  <!--如果这个大文件夹可以被别人import 就需要设定为jar -->
  <!--<packaging>jar</packaging> -->
  <!--  但是如果这个大文件是最大的父类，就需要设置为pom -->
  <packaging>pom</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>my-app-parent</name>
  <url>http://maven.apache.org</url>

  <!--  注意一开始创建的时候不能有下列modules,否则无法创建该子类，因为创建之后它会自动添加 -->
  <modules>
    <module>my-app-webapp</module>
  </modules>
  
</project>
```

3. 父项目和子模块的关系（一般自动创建)

在多模块项目中，父项目和子模块之间有一个很重要的关系：<u>子模块引用父项目</u>。这意味着子模块可以继承来自父项目的所有设置，例如依赖管理、插件管理等。

在子模块的pom.xml文件中，我们需要使用parent节点来声明该子模块所依赖的父项目：

```plain
<parent>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app-parent</artifactId>
  <version>1.0-SNAPSHOT</version>
</parent>
```

在父项目的pom.xml文件中，则需要使用**modules**节点来声明其中包含哪些子模块：

```plain
<modules>
  <module>my-app-webapp</module>
  <module>my-app-service</module>
  <module>my-app-dao</module>
</modules>
```

#### 多模块项目的构建
在构建多模块项目时，我们需要先进入父项目的目录进行构建。如果只构建父项目，则会同时构建所有子模块，例如：

```plain
cd my-app-parent
mvn clean install
```

如果只想构建某个子模块，则可以进入该子模块的目录进行构建，例如：

```plain
cd my-app-webapp
mvn clean package
```

在构建子模块时，Maven会自动检查父项目是否已经被构建，如果未被构建，则先构建父项目。这样，我们就可以轻松地构建多模块项目，并快速实现应用的部署。

#### <font style="color:rgb(25, 27, 31);">镜像设置</font>
<font style="color:rgb(25, 27, 31);">镜像是一个Maven仓库的映像，通俗点说就是一个网站。Maven中心库是每次构建Java项目时必须要访问的远程库，但是Maven官方中心库位于美国，由于众所周知的原因，其下载速度较慢。这时候，我们可以使用国内的Maven镜像来代替。</font>

<font style="color:rgb(25, 27, 31);">在</font>`<font style="color:rgb(25, 27, 31);">settings.xml</font>`<font style="color:rgb(25, 27, 31);">文件中，我们可以通过</font>`<font style="color:rgb(25, 27, 31);">mirrors</font>`<font style="color:rgb(25, 27, 31);">节点来配置Maven镜像，例如：</font>

```xml
<mirrors>
    <mirror>
        <id>aliyunmaven</id>
        <mirrorOf>*</mirrorOf>
        <name>阿里云公共仓库</name>
        <url>https://maven.aliyun.com/repository/public</url>
    </mirror>
</mirrors>
```

<font style="color:rgb(25, 27, 31);">以上配置表示使用阿里云的中央仓库作为Maven中心库的镜像源。 </font>
PS: 如何找到配置文件 `settings.xml` 呢？


1. 使用`mvn -v`命令

```bash
(base) root@DESKTOP:gulimall# mvn -v
Apache Maven 3.6.3
Maven home: /usr/share/maven
Java version: 17.0.15, vendor: Ubuntu, runtime: /usr/lib/jvm/java-17-openjdk-amd64
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "5.15.167.4-microsoft-standard-wsl2", arch: "amd64", family: "unix"
```

2. 则目录为 `**/usr/share/maven/conf/settings.xml**`

#### <font style="color:rgb(25, 27, 31);">代理设置</font>
<font style="color:rgb(25, 27, 31);">在某些情况下，我们需要通过代理服务器来进行网络请求。例如，在公司内部开发环境中，网络访问需要经过代理服务器才能访问外部网站。 在settings.xml文件中，我们可以通过proxies节点来配置Maven的代理设置，例如：</font>

```xml
<proxies>
  <proxy>
    <id>myproxy</id>
    <active>true</active>
    <protocol>http</protocol>
    <host>proxy.example.com</host>
    <port>8080</port>
    <username>myuser</username>
    <password>mypassword</password>
    <nonProxyHosts>localhost|*.example.com</nonProxyHosts>
  </proxy>
</proxies>
```

<font style="color:rgb(25, 27, 31);">以上配置表示使用一个名为myproxy的代理服务器，并指定了代理服务器的地址、端口、认证信息和非代理主机列表等信息。</font>

#### <font style="color:rgb(25, 27, 31);">证书设置</font>
<font style="color:rgb(25, 27, 31);">有些远程仓库需要授权才能下载其中的库。在这种情况下，我们需要通过配置证书来实现认证。</font>

<font style="color:rgb(25, 27, 31);">在settings.xml文件中，我们可以通过server节点来配置认证信息，例如：</font>

```xml
<servers>
  <server>
    <id>myserver</id>
    <username>myuser</username>
    <password>mypassword</password>
  </server>
</servers>
```

<font style="color:rgb(25, 27, 31);">以上配置表示认证一个名为myserver的远程仓库，并指定该仓库的用户名和密码。</font>

### <font style="color:rgb(25, 27, 31);">报错整理</font>
1. 当我的gulimail-common编译不过之后

首先处理**模块是否正确构建并安装到本地仓库**。首先，检查 gulimail-common 模块是否构建为 JAR 包,确保 gulimail-common 模块已经构建并安装到本地仓库。如果 gulimail-common 模块还没有被编译或安装到 Maven 本地仓库（~/.m2/repository），product 模块是无法找到它的。

解决方法：先在 gulimail-common 模块目录下运行 mvn install，确保它已被安装到本地仓库，然后再构建 gulimail-product 模块

```cpp
cd gulimall/gulimail-common && mvn clean install -q
```

验证是否已经被编译到本地仓库

```bash
ls -l ~/.m2/repository/com/atpepper/gulimail/gulimail-common/0.0.1-SNAPSHOT
```

	验证输出：

```bash
(base) root@DESKTOP:gulimall# l
total 32
-rw-r--r-- 1 root root   214 Nov 19 22:42 _remote.repositories
-rw-r--r-- 1 root root 14256 Nov 19 22:42 gulimail-common-0.0.1-SNAPSHOT.jar
-rw-r--r-- 1 root root  2141 Nov 19 21:11 gulimail-common-0.0.1-SNAPSHOT.pom
-rw-r--r-- 1 root root   166 Nov 19 21:06 m2e-lastUpdated.properties
-rw-r--r-- 1 root root   722 Nov 19 22:42 maven-metadata-local.xml
```

局部编译`product`模块

```bash
cd /Java/gulimall && mvn -pl gulimail-product -am clean compile -q
```

冲突依赖排查

如果有多个版本的 gulimail-common 存在于项目的依赖树中，可能会导致冲突，Maven 会选择一个版本来解析依赖，而其他版本可能被忽略。

```bash
mvn dependency:tree 
#来查看项目的依赖树，确保没有版本冲突。
```



1 文件命名问题，需要注意

对应`test`和`main`

![](https://images.weserv.nl/?url=cdn.nlark.com/yuque/0/2025/png/40742019/1763610664806-eef012ca-b7f9-45e1-ade7-54c93cf84000.png)

















---