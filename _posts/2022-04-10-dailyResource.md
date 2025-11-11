---
title: 'dailyResource'
lang: zh-CN
date: 2022-04-10
author: pepper
permalink: /posts/2025/04/dailyResource/
pinned: true
toc: true
tags:
  - daily
---
这篇博客介绍了一些日常收集整理资料。
<!-- more -->
---

## 1 常见的日常积累小技巧

1. mac 电脑外接显示屏
   对于屏幕分辨率的问题，其中较好的一个仓库软件叫做 `betterdisaplay`，可以用来调整刷新赫兹以及分辨率，但是要注意下载符合mac的系统版本的软件；

```shell
https://github.com/waydabber/BetterDisplay/releases?page=6
```

2. Adobe ps 免费激活版本 ：[link](https://www.cnblogs.com/FRIM/p/18130753)

3. 绘图的时候图例位置参数设置

      ```python
        # 紧凑型图例
        handles, labels = plt.gca().get_legend_handles_labels()
        plt.legend(handles[:35], labels[:35], loc='upper right', 
                  ncol=2, columnspacing=0.8, handletextpad=0.5)
        
        # 自动检测最佳位置
        # plt.legend(
        #     loc='best',
        #     bbox_to_anchor=(1, 0.5),  # 右侧垂直居中
        #     borderaxespad=0.5,
        #     framealpha=0.9
        # )
        
        # plt.legend(
        # loc='upper center',
        # bbox_to_anchor=(0.5, -0.15),  # 向下偏移15%
        # ncol=2,
        # frameon=True,
        # shadow=True,
        # fancybox=True
        # )
      ```

4. google colab 时刻触发脚本

      ```java
      function ConnectButton(){
          console.log("Connect pushed");
          document.querySelector("#top-toolbar > colab-connect-button").shadowRoot.querySelector("#connect").click()
      }
      setInterval(ConnectButton,60000);
      ```

## 2 代码运行常见

### 1. 后台进程管理方案

- 使用nohup持久运行

    ```bash
    nohup python -u run_script.py > script.log 2>&1 &

    # - 参数说明
    # nohup：忽略挂断信号
    #  -u（Python参数）：禁用输出缓冲
    #  > script.log：标准输出重定向
    #  2>&1：错误输出合并
    #   &：后台运行 
    ```

- 验证进程状态

  ```bash
  # 查看进程列表
  ps aux | grep "python run_script.py"
  # 实时监控日志
  tail -f script.log
  ```

- 终止进程

  ```bash
  # 优雅终止
  pkill -f "python run_script.py"
  # 强制终止（无响应时）
  kill -9 1708
  ```

- 高级管理方案（生产环境推荐）, 使用systemd服务 创建服务文件。

  ```bash
  sudo nano /etc/systemd/model.service
  ```

- 服务内容：

  ```bash
  [Unit]
  Description=Model Training Service
  [Service]
  User=root
  WorkingDirectory=/root/PDFormer
  ExecStart=/root/miniconda3/envs/base/bin/python run_script.py
  Restart=always
  StandardOutput=file:/var/log/model.log
  StandardError=file:/var/log/model_error.log
  [Install]
  WantedBy=multi-user.target
  ```

- 启用服务：

  ```bash
  sudo systemctl daemon-reload
  sudo systemctl enable model
  sudo systemctl start model
  ```

  - 使用tmux会话管理

  ```bash
  # 安装tmux
  sudo apt install tmux -y

  # 创建会话
  tmux new -s model_train

  # 在会话中运行
  python run_script.py

  # 分离会话
  Ctrl+B → D

  # 重连会话
  tmux attach -t model_train

  # 打开现有会话
  tmux attach -t python_session
  ```

  ### 2. Markdown常用快捷键

  ```java
  Ctrl 0 到 Ctrl 6： 普通文本、一级文本~六级文本
  Ctrl B： 加粗
  Ctrl I： 斜体
  Ctrl U： 下划线
  Shift Alt 5： 删除线
  Shift Ctrl ~： 行内代码块
  Ctrl K： 超链接
  Ctrl T： 表格
  Ctrl Shift Q： 引用
  Shift Ctrl I： 插入图片
  Shift Ctrl M： 公式块
  [ ]： 任务列表(可勾选的序列)
  <sup>内容</sup>： 上标
  <sub>内容</sub>： 下标
  :smile:： 😄
  [toc]： 展示目录
  Ctrl L： 选中一行
  Ctrl D： 选中内容/单词
  Ctrl Home： 跳转到文章开头
  Ctrl End： 跳转到文章结尾
  Ctrl F： 搜索
  Ctrl H： 替换
  ```

  ## 3 学习资源

  ### 1. 书籍资源

  ```java
  主站: http://www.https.ng
  镜像站点:
  - http://38.147.170.240:5959
  - http://103.74.192.62:1234
  - http://45.145.228.151
  - http://193.134.211.102:1234

  EPUB资源:
  http://38.147.170.240:5959/c1/baidupan/222222/其它/EPUB

  注意: 使用http协议,不要加https
  ```
  
---
