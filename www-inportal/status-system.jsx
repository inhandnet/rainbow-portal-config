<% sysinfo(); %>

stats = { };

do {
	var a, b, i;

	stats.cpuload = ((sysinfo.loads[0] / 65536.0).toFixed(2) + ' / ' +
		(sysinfo.loads[1] / 65536.0).toFixed(2) + ' / ' +
		(sysinfo.loads[2] / 65536.0).toFixed(2));
	stats.uptime = sysinfo.uptime_s;

	a = sysinfo.totalram + sysinfo.totalswap;
	b = sysinfo.totalfreeram + sysinfo.freeswap;
	stats.memory = scaleSize(a) + ' / ' + scaleSize(b) + " (" + (b / a * 100.0).toFixed(2) + '%)';

	stats.time = '<% time(); %>';
} while (0);

<% web_exec('show cellular')%>
<% web_exec('show interface')%>