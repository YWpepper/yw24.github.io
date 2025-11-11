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

      ```JavaScript
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

  ```txt
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

  ### 1. 美剧资源

  - [Hacks - Season 1](https://cineb.rs/watch-tv/watch-hacks-free-69823.4805626)

  ### 2. 书籍资源

  ```txt
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

  ## 4 Traffic Prediction 论文资源

  ### 1. 概述

  交通预测是利用历史数据(时间序列)预测道路网络(图)中未来交通测量值(如流量、速度等)的任务。

  更新列表参考: <https://github.com/lixus7/Time-Series-Works-Conferences>

  ### 2. 数据集

  #### 公开数据集

  - **METR-LA**
    - [DCRNN Google Drive](https://drive.google.com/drive/folders/10FOTa6HXPqX8Pf5WRoRwcFnW9BrNZEIX)
    - [DCRNN Baidu](https://pan.baidu.com/s/14Yy9isAIZYdU__OYEQGa_g#list/path=%2F)
    - [传感器坐标和邻接矩阵](https://github.com/liyaguang/DCRNN/tree/master/data/sensor_graph)

  - **PeMS系列** (California PeMS: <http://pems.dot.ca.gov/>)
    - PeMS-BAY, PeMS-D7(M), PeMS-D7(L)
    - PeMS-04, PeMS-08, PeMS-03, PeMS-07
    - [下载地址](https://github.com/Davidham3/ASTGCN/tree/master/data)

  - **LOOP**: <https://github.com/zhiyongc/Seattle-Loop-Data>

  - **Q-Traffic**: <https://github.com/JingqingZ/BaiduTraffic>

  ### 3. 工具库

  - [LibCity](https://libcity.ai/) - [GitHub](https://github.com/LibCity/Bigscity-LibCity)
  - [Tsinghua Fib Lab](https://github.com/tsinghua-fib-lab/Traffic-Benchmark)
  - [PyTorch Geometric](https://pytorch-geometric.readthedocs.io)

  ### 4. 论文列表

  | 模型 | 会议 | 年份 | 论文 | 代码 |
  |:---:|:---:|:---:|:---:|:---:|
  | G-SWaN | IoTDI | 2023 | [Link](https://arxiv.org/abs/2302.09956) | [PyTorch](https://github.com/aprbw/G-SWaN) |
  | SCPT | ArXiv | 2023 | [Link](https://arxiv.org/abs/2305.05237) | - |
  | AGCRN | ArXiv | 2020 | [Link](https://arxiv.org/abs/2007.02842) | [PyTorch](https://github.com/LeiBAI/AGCRN) |
  | DCRNN | ICLR | 2018 | [Link](https://arxiv.org/abs/1707.01926v3) | [TF](https://github.com/liyaguang/DCRNN) |
  | STGCN | IJCAI | 2018 | [Link](https://arxiv.org/abs/1709.04875) | [PyTorch](https://github.com/FelixOpolka/STGCN-PyTorch) |
  | GWN | IJCAI | 2019 | [Link](https://www.ijcai.org/Proceedings/2019/0264.pdf) | [PyTorch](https://github.com/nnzhan/Graph-WaveNet) |

  ### 5. 相关资源

  - [Graph Neural Network for Traffic Forecasting Survey](https://arxiv.org/abs/2101.11174)
  - [BigsCity LibCity论文集](https://github.com/LibCity/Bigscity-LibCity-Paper)
  - [DL-Traff基准测试](https://github.com/deepkashiwa20/DL-Traff-Grid)
