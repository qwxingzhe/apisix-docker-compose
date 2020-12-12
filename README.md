
# apisix-docker-compose

#### 1.极速开始
###### 1.1 安装简洁组合
- apisix
- etcd
- apisix-dashboard

~~~
// 下载安装
git clone https://github.com/qwxingzhe/apisix-docker-compose.git
cd apisix-docker-compose/simple
docker-compose up -d

// 查看是否启动成功
docker-compose ps
~~~


###### 1.2 浏览器访问 apisix-dashboard
> 访问地址： http://{替换成你的IP地址}:9000



#### 2.ApiSix及相关应用安装
###### 2.1 安装应用组合
- apisix
- etcd
- apisix-dashboard
- grafana
- prometheus

~~~
// 下载安装
git clone https://github.com/qwxingzhe/apisix-docker-compose.git
cd apisix-docker-compose/senior
docker-compose up -d

// 查看是否启动成功
docker-compose ps
~~~


###### 2.2 浏览器访问 
> **apisix-dashboard**
> 访问地址： http://{替换成你的IP地址}:9000
> 
> **grafana**
> 访问地址： http://{替换成你的IP地址}:3000
> 
> **prometheus**
> 访问地址： http://{替换成你的IP地址}:9090