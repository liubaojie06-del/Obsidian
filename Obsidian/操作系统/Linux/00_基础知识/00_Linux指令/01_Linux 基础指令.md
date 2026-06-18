---
tags: [Linux, 基础指令, 命令行, Shell, 终端, 编程基础]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | Linux 基础指令：用命令行控制系统

> [!abstract] 核心结论
> Linux 基础指令的核心是：通过终端输入命令，让 Shell 帮我们操作文件、目录、权限、进程、网络和系统环境。掌握基础指令后，就能脱离图形界面完成大部分开发与运维操作。

### ① 底层原理：Linux 指令到底做了什么

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>Linux 命令执行流程：</strong>
<ul>
  <li><strong>用户输入命令：</strong> 例如 <code>ls -l</code>。</li>
  <li><strong>Shell 解析命令：</strong> 分析命令名、选项、参数、路径。</li>
  <li><strong>系统查找命令：</strong> 在 <code>PATH</code> 环境变量指定的目录中寻找可执行程序。</li>
  <li><strong>内核执行操作：</strong> 通过系统调用访问文件、目录、进程、网络等资源。</li>
  <li><strong>结果返回终端：</strong> 输出到屏幕，或者通过重定向写入文件。</li>
</ul>
</div>

### ② 命令基本格式

```bash
命令 [选项] [参数]
```

示例：

```bash
ls -l /home
```

理解：

```text
ls      命令名，表示列出目录内容
-l      选项，表示使用详细格式
/home   参数，表示要查看的目录
```

### ③ 终端常用快捷键

| 快捷键 | 作用 |
| :--- | :--- |
| `Ctrl + C` | 终止当前正在运行的命令 |
| `Ctrl + D` | 退出当前终端 / 输入结束 |
| `Ctrl + L` | 清屏，等价于 `clear` |
| `Ctrl + A` | 光标移动到命令行开头 |
| `Ctrl + E` | 光标移动到命令行结尾 |
| `Ctrl + U` | 删除光标前面的内容 |
| `Ctrl + K` | 删除光标后面的内容 |
| `Ctrl + R` | 搜索历史命令 |
| `Tab` | 自动补全命令或路径 |
| `↑ / ↓` | 切换历史命令 |

> [!tip] 记忆口诀
> **命令有三段：命令、选项、参数；Tab 补全提效率，Ctrl+C 用来保命。**

---

# 02 | 目录与路径基础指令

> [!abstract] 核心结论
> 目录操作是 Linux 的第一层基本功。`pwd` 查看当前位置，`ls` 查看目录内容，`cd` 切换目录，`mkdir` 创建目录，`rmdir` 删除空目录。

### ① 查看当前目录

```bash
pwd
```

作用：

```text
显示当前所在目录的绝对路径。
```

示例输出：

```text
/home/user/project
```

---

### ② 查看目录内容

```bash
ls
ls -l
ls -a
ls -lh
ls -la
```

说明：

```text
ls       查看当前目录内容
ls -l    使用详细格式显示
ls -a    显示隐藏文件
ls -lh   以人类可读方式显示文件大小
ls -la   显示全部文件并使用详细格式
```

---

### ③ 切换目录

```bash
cd /home
cd ..
cd .
cd ~
cd -
```

说明：

```text
cd /home   切换到 /home 目录
cd ..      返回上一级目录
cd .       表示当前目录
cd ~       回到当前用户家目录
cd -       返回上一次所在目录
```

---

### ④ 创建目录

```bash
mkdir test
mkdir -p a/b/c
```

说明：

```text
mkdir test      创建 test 目录
mkdir -p a/b/c  递归创建多级目录
```

---

### ⑤ 删除空目录

```bash
rmdir test
```

说明：

```text
rmdir 只能删除空目录。
如果目录里面有内容，需要使用 rm -r。
```

### ⑥ 常见路径符号

| 符号 | 含义 |
| :--- | :--- |
| `/` | 根目录 |
| `.` | 当前目录 |
| `..` | 上一级目录 |
| `~` | 当前用户家目录 |
| `-` | 上一次所在目录 |

> [!tip] 记忆口诀
> **`pwd` 看位置，`ls` 看内容；`cd` 来移动，`mkdir` 建目录。**

---

# 03 | 文件基础操作指令

> [!abstract] 核心结论
> Linux 文件操作围绕“创建、复制、移动、删除”展开。`touch` 创建文件，`cp` 复制，`mv` 移动或改名，`rm` 删除。

### ① 创建空文件

```bash
touch a.txt
touch file1 file2 file3
```

作用：

```text
创建空文件。
如果文件已经存在，则更新文件的修改时间。
```

---

### ② 复制文件

```bash
cp a.txt b.txt
cp a.txt /tmp/
```

说明：

```text
cp a.txt b.txt   复制 a.txt，并命名为 b.txt
cp a.txt /tmp/   把 a.txt 复制到 /tmp 目录
```

---

### ③ 复制目录

```bash
cp -r dir1 dir2
```

说明：

```text
-r 表示递归复制。
复制目录时必须加 -r。
```

---

### ④ 移动文件或重命名

```bash
mv old.txt new.txt
mv a.txt /tmp/
mv dir1 dir2
```

说明：

```text
mv old.txt new.txt   重命名文件
mv a.txt /tmp/       移动文件到 /tmp 目录
mv dir1 dir2         移动目录或重命名目录
```

---

### ⑤ 删除文件

```bash
rm a.txt
rm -i a.txt
rm -f a.txt
```

说明：

```text
rm a.txt     删除文件
rm -i a.txt  删除前询问
rm -f a.txt  强制删除，不提示
```

---

### ⑥ 删除目录

```bash
rm -r dir
rm -rf dir
```

说明：

```text
rm -r dir   递归删除目录
rm -rf dir  强制递归删除目录，非常危险
```

危险提醒：

```text
rm -rf /      极度危险，可能删除整个系统
rm -rf ~      极度危险，可能删除当前用户所有文件
rm -rf *      危险，会删除当前目录下所有内容
```

> [!tip] 记忆口诀
> **`touch` 创建，`cp` 复制；`mv` 搬家又改名，`rm -rf` 用前三思。**

---

# 04 | 文件查看基础指令

> [!abstract] 核心结论
> 查看文件不一定要打开编辑器。小文件用 `cat`，大文件用 `less`，看开头用 `head`，看结尾用 `tail`，统计内容用 `wc`。

### ① 查看完整文件

```bash
cat file.txt
cat -n file.txt
```

说明：

```text
cat file.txt     查看整个文件内容
cat -n file.txt  显示行号
```

---

### ② 分页查看文件

```bash
less file.txt
more file.txt
```

说明：

```text
less 适合查看大文件。
more 功能较简单。
```

less 常用按键：

```text
空格       下一页
b          上一页
/关键词    搜索关键词
n          下一个搜索结果
q          退出
```

---

### ③ 查看文件开头

```bash
head file.txt
head -n 20 file.txt
```

说明：

```text
head 默认查看前 10 行。
head -n 20 查看前 20 行。
```

---

### ④ 查看文件结尾

```bash
tail file.txt
tail -n 20 file.txt
tail -f app.log
```

说明：

```text
tail 默认查看后 10 行。
tail -n 20 查看后 20 行。
tail -f 实时追踪文件变化，常用于看日志。
```

---

### ⑤ 统计文件内容

```bash
wc file.txt
wc -l file.txt
wc -w file.txt
wc -c file.txt
```

说明：

```text
wc       显示行数、单词数、字节数
wc -l    统计行数
wc -w    统计单词数
wc -c    统计字节数
```

> [!tip] 记忆口诀
> **小文件 `cat`，大文件 `less`；看头 `head`，看尾 `tail -f`。**

---

# 05 | 查找文件与搜索内容

> [!abstract] 核心结论
> `find` 用来查找文件，`grep` 用来搜索文件内容。一个找文件名，一个找文件里的文字。

### ① find 按名称查找

```bash
find . -name "a.txt"
find /home -name "*.c"
find . -name "*.log"
```

说明：

```text
find . -name "a.txt"    在当前目录查找 a.txt
find /home -name "*.c"  在 /home 下查找所有 .c 文件
find . -name "*.log"   查找当前目录下所有日志文件
```

---

### ② find 按类型查找

```bash
find . -type f
find . -type d
```

说明：

```text
-type f  查找普通文件
-type d  查找目录
```

---

### ③ find 按大小查找

```bash
find . -size +100M
find . -size -1M
```

说明：

```text
-size +100M  查找大于 100MB 的文件
-size -1M    查找小于 1MB 的文件
```

---

### ④ grep 搜索文件内容

```bash
grep "main" file.c
grep -n "main" file.c
grep -r "TODO" .
grep -i "error" app.log
grep -v "debug" app.log
```

说明：

```text
grep "main" file.c    在 file.c 中搜索 main
grep -n               显示行号
grep -r               递归搜索目录
grep -i               忽略大小写
grep -v               反向匹配，排除包含关键词的行
```

---

### ⑤ find + grep 组合

```bash
find . -name "*.c" | xargs grep -n "printf"
```

说明：

```text
先找出当前目录下所有 .c 文件。
再在这些文件里搜索 printf，并显示行号。
```

> [!tip] 记忆口诀
> **找文件用 `find`，找内容用 `grep`；显示行号加 `-n`，递归搜索加 `-r`。**

---

# 06 | 权限基础指令

> [!abstract] 核心结论
> Linux 权限决定谁能读、写、执行文件。`chmod` 修改权限，`chown` 修改所有者，`sudo` 使用管理员权限。

### ① 查看权限

```bash
ls -l
```

示例：

```text
-rwxr-xr-- 1 user group 1234 May 23 run.sh
```

理解：

```text
第 1 位：文件类型
后 9 位：权限

r：read，读权限
w：write，写权限
x：execute，执行权限
```

权限分组：

```text
rwx   文件所有者权限
r-x   所属组权限
r--   其他用户权限
```

---

### ② 添加执行权限

```bash
chmod +x run.sh
```

作用：

```text
给 run.sh 添加执行权限。
之后可以使用 ./run.sh 运行。
```

---

### ③ 数字方式修改权限

```bash
chmod 755 run.sh
chmod 644 file.txt
```

说明：

```text
chmod 755 run.sh：
所有者可读写执行，其他人可读执行。

chmod 644 file.txt：
所有者可读写，其他人只读。
```

数字含义：

```text
r = 4
w = 2
x = 1

7 = 4 + 2 + 1 = rwx
6 = 4 + 2     = rw-
5 = 4 + 1     = r-x
4 = 4         = r--
```

---

### ④ 修改所有者

```bash
sudo chown user file.txt
sudo chown user:group file.txt
sudo chown -R user:group dir
```

说明：

```text
chown user file.txt          修改文件所有者
chown user:group file.txt    修改所有者和所属组
chown -R user:group dir      递归修改目录所有者
```

---

### ⑤ sudo 管理员权限

```bash
sudo command
sudo apt update
sudo systemctl restart nginx
```

说明：

```text
sudo 表示以管理员权限执行命令。
```

> [!tip] 记忆口诀
> **读写执行 `rwx`，改权 `chmod`，改主 `chown`，管理员用 `sudo`。**

---

# 07 | 压缩与解压基础指令

> [!abstract] 核心结论
> Linux 中最常见的打包压缩工具是 `tar`。`.tar.gz` 文件用 `tar -zcvf` 创建，用 `tar -zxvf` 解压。

### ① tar 打包

```bash
tar -cvf archive.tar dir
```

说明：

```text
-c  创建归档文件
-v  显示过程
-f  指定文件名
```

---

### ② tar.gz 打包压缩

```bash
tar -zcvf archive.tar.gz dir
```

说明：

```text
-z 表示使用 gzip 压缩。
```

---

### ③ 解压 tar 文件

```bash
tar -xvf archive.tar
```

说明：

```text
-x 表示解包。
```

---

### ④ 解压 tar.gz 文件

```bash
tar -zxvf archive.tar.gz
tar -zxvf archive.tar.gz -C /tmp
```

说明：

```text
tar -zxvf archive.tar.gz       解压到当前目录
tar -zxvf archive.tar.gz -C /tmp  解压到 /tmp 目录
```

---

### ⑤ zip 与 unzip

```bash
zip -r archive.zip dir
unzip archive.zip
unzip archive.zip -d /tmp
```

说明：

```text
zip -r archive.zip dir      压缩目录
unzip archive.zip           解压 zip 文件
unzip archive.zip -d /tmp   解压到指定目录
```

> [!tip] 记忆口诀
> **打包 `tar -cvf`，压缩加 `z`；解压 `tar -xvf`，`.tar.gz` 用 `zxvf`。**

---

# 08 | 进程与系统资源指令

> [!abstract] 核心结论
> 进程管理用于查看程序运行状态、结束异常程序、监控 CPU / 内存 / 磁盘占用。常用命令有 `ps`、`top`、`kill`、`df`、`du`、`free`。

### ① 查看进程

```bash
ps
ps aux
ps aux | grep nginx
```

说明：

```text
ps             查看当前终端相关进程
ps aux         查看系统所有进程
grep nginx     过滤 nginx 相关进程
```

---

### ② 动态查看系统资源

```bash
top
htop
```

说明：

```text
top   系统自带资源监控工具
htop  更友好的资源监控工具，部分系统需要额外安装
```

---

### ③ 结束进程

```bash
kill PID
kill -9 PID
pkill nginx
```

说明：

```text
kill PID      请求进程结束
kill -9 PID   强制结束进程
pkill nginx   按进程名结束进程
```

---

### ④ 查看磁盘空间

```bash
df -h
```

说明：

```text
查看磁盘分区空间使用情况。
-h 表示以人类可读方式显示。
```

---

### ⑤ 查看目录大小

```bash
du -sh *
du -sh /var/log
```

说明：

```text
du -sh *         查看当前目录下各文件 / 目录大小
du -sh /var/log  查看 /var/log 目录大小
```

---

### ⑥ 查看内存

```bash
free -h
```

说明：

```text
查看系统内存和交换分区使用情况。
```

> [!tip] 记忆口诀
> **进程看 `ps`，资源看 `top`；磁盘看 `df`，目录大小看 `du`。**

---

# 09 | 网络与软件安装指令

> [!abstract] 核心结论
> Linux 网络指令用于测试连通性、查看 IP、查看端口、下载文件；软件安装通常依赖系统包管理器，例如 `apt`、`yum`、`dnf`、`pacman`。

### ① 测试网络连通

```bash
ping baidu.com
ping -c 4 google.com
```

说明：

```text
ping 用于测试网络是否连通。
-c 4 表示只发送 4 次请求。
```

---

### ② 查看 IP 地址

```bash
ip addr
ip a
hostname -I
```

说明：

```text
ip addr      查看网卡和 IP 地址
ip a         ip addr 的简写
hostname -I  快速显示本机 IP
```

---

### ③ 查看端口

```bash
ss -tulnp
netstat -tulnp
```

说明：

```text
ss -tulnp       查看监听端口和对应进程
netstat -tulnp  老工具，部分系统需要额外安装
```

---

### ④ 下载文件

```bash
wget URL
curl URL
curl -O URL
```

说明：

```text
wget URL     下载文件
curl URL     输出网页或接口内容
curl -O URL  按原文件名保存文件
```

---

### ⑤ Ubuntu / Debian 安装软件

```bash
sudo apt update
sudo apt install package
sudo apt remove package
```

说明：

```text
apt update           更新软件源信息
apt install package  安装软件包
apt remove package   卸载软件包
```

---

### ⑥ CentOS / RHEL 安装软件

```bash
sudo yum install package
sudo yum remove package
```

---

### ⑦ Fedora 安装软件

```bash
sudo dnf install package
sudo dnf remove package
```

---

### ⑧ Arch Linux 安装软件

```bash
sudo pacman -S package
sudo pacman -R package
```

> [!tip] 记忆口诀
> **网络先 `ping`，IP 看 `ip a`；端口看 `ss`，安装软件找包管理器。**

---

# 10 | 管道、重定向与常用组合

> [!abstract] 核心结论
> 管道和重定向是 Linux 命令行的灵魂。管道把一个命令的输出交给下一个命令，重定向把输出写入文件。多个简单命令组合起来，可以完成复杂任务。

### ① 管道符 |

```bash
ls | grep ".c"
ps aux | grep nginx
cat file.txt | wc -l
```

说明：

```text
| 会把左边命令的输出，交给右边命令继续处理。
```

---

### ② 输出重定向

```bash
echo "hello" > a.txt
echo "world" >> a.txt
ls > files.txt
```

说明：

```text
>   覆盖写入文件
>>  追加写入文件
```

---

### ③ 错误重定向

```bash
command 2> error.log
command > output.log 2>&1
```

说明：

```text
2>       把错误输出写入文件
2>&1     把错误输出合并到标准输出
```

---

### ④ 查看历史命令

```bash
history
history | grep gcc
!!
```

说明：

```text
history            查看历史命令
history | grep gcc 搜索历史命令中的 gcc
!!                 执行上一条命令
```

---

### ⑤ 常用实战组合

**查找当前目录下所有 C 文件：**

```bash
find . -name "*.c"
```

**递归搜索 TODO：**

```bash
grep -rn "TODO" .
```

**查看当前目录下文件大小并排序：**

```bash
du -sh * | sort -h
```

**实时查看日志：**

```bash
tail -f app.log
```

**查找 Python 进程：**

```bash
ps aux | grep python
```

**给脚本执行权限并运行：**

```bash
chmod +x run.sh && ./run.sh
```

**创建项目目录并进入：**

```bash
mkdir -p project/src && cd project
```

### ⑥ 高频命令速查

| 命令 | 作用 |
| :--- | :--- |
| `pwd` | 查看当前目录 |
| `ls -la` | 查看所有文件详情 |
| `cd ..` | 返回上一级 |
| `mkdir -p a/b/c` | 创建多级目录 |
| `touch a.txt` | 创建空文件 |
| `cp -r a b` | 复制目录 |
| `mv a b` | 移动或改名 |
| `rm -rf dir` | 强制删除目录 |
| `cat file` | 查看文件 |
| `less file` | 分页查看文件 |
| `tail -f log` | 实时看日志 |
| `grep -rn key .` | 递归搜索关键字 |
| `find . -name "*.c"` | 查找 C 文件 |
| `chmod +x file` | 添加执行权限 |
| `ps aux` | 查看进程 |
| `kill -9 PID` | 强制结束进程 |
| `df -h` | 查看磁盘空间 |
| `du -sh *` | 查看目录大小 |
| `free -h` | 查看内存 |
| `ping host` | 测试网络 |
| `ip addr` | 查看 IP |
| `ss -tulnp` | 查看端口 |
| `tar -zcvf a.tar.gz dir` | 打包压缩 |
| `tar -zxvf a.tar.gz` | 解压 |
| `wget URL` | 下载文件 |
| `sudo apt install pkg` | 安装软件 |

> [!tip] 终极口诀
> **查目录 `ls`，进目录 `cd`；看文件 `cat/less`，搜内容 `grep`；找文件 `find`，看进程 `ps`；组合全靠管道符。**