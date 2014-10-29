var help = new Object();
ui.help="欢迎使用！";
menu.system="设置系统参数";
menu.network="设置网络参数";
menu.services="设置系统服务参数";
menu.fw="设置防火墙参数";
menu.tools="系统/网络工具";
menu.stat="查看系统/网络状态";

menu.setup_system="<li>界面语言：可选择操作界面的语言.</li>";
menu.setup_time="<li>交换机时间: 显示当前交换机的时间;</li><li>主机时间: 显示PC主机的时间;</li>";
menu.admin_access="<li>用户名：管理交换机的用户名；</li><li>密码：登录密码</li><li>确认密码：再次输入登录密码</li><li>管理功能：设置交换机的管理方式，可同时启用多种管理方式，并可以限制指定管理方式的管理端口、是否允许本地（通过LAN口）和远程（通过WAN口）管理、允许远程管理的IP地址范围（可通过类似192.168.0.1-192.168.0.100或192.168.0.0/24等方式指定）等</li><li>登录超时: 设置用户登录超时时间.如果期间没有操作,就会退出登录.这个时间会影响上面所有说的所有登录方式.</li>";
menu.admin_log="<li>发送到远程日志服务器：是否发送交换机日志到远程日志服务器；</li><li>日志服务器的地址/端口：指定日志服务器的IP地址和端口</li>";
menu.upgrd="<li>选择一个交换机固件文件，升级交换机</li>";
menu.about="<li>访问<a href='http://www.inhand.com.cn'>www.inhand.com.cn</a>获取更多产品信息</li>";
menu.setup_dns="<li>首选域名服务器：设置主域名服务器；</li><li>备选域名服务器：选择备用的域名服务器</li>";
menu.setup_ddns="<li>为WAN端口和拨号端口指定动态域名，每个接口可以各分配一个动态域名。</li><li>当前地址：端口当前的IP地址；</li><li>服务类型：选择一种服务类型；</li><li>URL：更新时请求的URL地址；</li><li>用户名：更新帐号；</li><li>密码：更新密码；</li><li>主机名：分配的动态域名</li><li>通配符：是否使用通配符；</li><li>MX和备份MX：是否更新邮箱记录；</li><li>强制更新：修改设置后强制更新记录；</li><li>上一次更新：上一次更新的时间；</li><li>上一次回应：上一次更新域名时域名服务器的回应消息；</li>";
menu.service_dnsrelay="<li>DNS转发服务用于为局域网内的计算机提供DNS解析服务，开启后局域网内的计算机只需要指定路由器的内网地址作为DNS服务器即可；</li><li>启用DNS转发服务：是否在LAN端口开启DNS转发服务；</li><li>指定[IP地址 <=> 域名]对：可把指定的域名解析为指定的IP地址；</li>";
menu.status_system="<li>显示系统状态信息</li>";
menu.status_log="<li>下载系统诊断记录: 当用户遇到困难时,可以下载系统诊断记录,把它发给技术支持,技术支持会第一时间解决用户的困难.</li>";

menu.template="<li></li><li></li><li></li>";
menu.port_mirror="<li>Session ID: 镜像号</li><li>Destination: 目的端口.</li><li>Source: 源端口.</li><li>Data Direction: </li><li>  both: 端口收到和发送的数据.</li><li>  ingress: 仅端口收到的数据.</li><li>  egress: 仅端口发出的数据.</li>";
menu.multicast_groups="<li>VLAN ID: vlan号.</li>IP Address: 静态组播地址.<li>Port: 组播端口.</li>";
menu.switch_mac="<li>老化时间: Mac地址老化时间.</li><li>Mac 地址: 添加Mac地址到静态Mac地址表.</li><li>VLAN: 指定Mac地址接收的VLAN包.</li><li>Port: 指定包转发的端口.</li>";
menu.switch_dynamic_mac="<li>删除动态Mac地址:</li><li>port: 删除指定端口上的动态Mac地址.</li><li>vlan: 删除在指定Vlan中的动态Mac地址.</li><li>all: 删除所有动态Mac地址.</li>";
menu.switch_stp="<li>快速生成树协议</li>";
menu.switch_trunk="<li>链路聚合</li>";
menu.switch_igmp="<li>互联网组管理协议</li>";

