Array.prototype.find = function(v) {
	for (var i = 0; i < this.length; ++i)
		if (this[i] == v) return i;
	return -1;
}

Array.prototype.remove = function(v) {
	for (var i = 0; i < this.length; ++i) {
		if (this[i] == v) {
			this.splice(i, 1);
			return true;
		}
	}
	return false;
}

// -----------------------------------------------------------------------------

String.prototype.trim = function() {
	return this.replace(/^\s+/, '').replace(/\s+$/, '');
}

// -----------------------------------------------------------------------------

Number.prototype.pad = function(min) {
	var s = this.toString();
	while (s.length < min) s = '0' + s;
	return s;
}

Number.prototype.hex = function(min)
{
	var h = '0123456789ABCDEF';
	var n = this;
	var s = '';
	do {
		s = h.charAt(n & 15) + s;
		n = n >>> 4;
	} while ((--min > 0) || (n > 0));
	return s;
}

// -----------------------------------------------------------------------------

//	Element.protoype. doesn't work with all browsers

var elem = {
	getOffset: function(e) {
		var r = { x: 0, y: 0 };
		e = E(e);
		while (e.offsetParent) {
			r.x += e.offsetLeft;
			r.y += e.offsetTop;
			e = e.offsetParent;
		}
		return r;
	},

	addClass: function(e, name) {
		if ((e = E(e)) == null) return;
		var a = e.className.split(/\s+/);
		var k = 0;
		for (var i = 1; i < arguments.length; ++i) {
			if (a.find(arguments[i]) == -1) {
				a.push(arguments[i]);
				k = 1;
			}
		}
		if (k) e.className = a.join(' ');
	},

	removeClass: function(e, name) {
		if ((e = E(e)) == null) return;
		var a = e.className.split(/\s+/);
		var k = 0;
		for (var i = 1; i < arguments.length; ++i)
			k |= a.remove(arguments[i]);
		if (k) e.className = a.join(' ');
	},

	remove: function(e) {
		 if ((e = E(e)) != null) e.parentNode.removeChild(e);
	},

    parentElem: function(e, tagName) {
		e = E(e);
		tagName = tagName.toUpperCase();
		while (e.parentNode) {
			e = e.parentNode;
			if (e.tagName == tagName) return e;
		}
		return null;
	},

	display: function() {
		var enable = arguments[arguments.length - 1];
		for (var i = 0; i < arguments.length - 1; ++i) {
			E(arguments[i]).style.display = enable ? '' : 'none';
		}
	},

	display2: function() {
		var enable = arguments[arguments.length - 1];
		for (var i = 0; i < arguments.length - 1; ++i) {
			elem.display(PR(arguments[i]), enable);
		}
	},
	
	enable: function() {
		var enable = arguments[arguments.length - 1];
		for (var i = 0; i < arguments.length - 1; ++i) {
			E(arguments[i]).disabled = ! enable;
		}
	},

	display_and_enable: function() {
		var enable = arguments[arguments.length - 1];
		for (var i = 0; i < arguments.length - 1; ++i) {
			elem.display(PR(arguments[i]), enable);
			
//			E(arguments[i]).style.display = enable ? '' : 'none';
			E(arguments[i]).disabled = ! enable;
		}
	},
	
	isVisible: function(e) {
		e = E(e);
		while (e) {
			if ((e.style.visibility != 'visible') || (e.style.display == 'none')) return false;
			e = e.parentNode;
		}
		return true;
	},

	setInnerHTML: function(e, html) {
		 e = E(e);
		 if (e.innerHTML != html) e.innerHTML = html;	// reduce flickering
	}
};

// -----------------------------------------------------------------------------

var docu = {
	getViewSize: function() {
		if (window.innerHeight) {
			return { width: window.innerWidth, height: window.innerHeight };
		}
		else if (document.documentElement && document.documentElement.clientHeight) {
			return { width: document.documentElement.clientWidth, height: document.documentElement.clientHeight };
		}
		return { width: document.body.clientWidth, height: document.body.clientHeight };
	},

	getPageOffset: function()
	{
		if (typeof(window.pageYOffset) != 'undefined') {
			return { x: window.pageXOffset, y: window.pageYOffset };
		}
		else if ((document.documentElement) && (typeof(document.documentElement.scrollTop) != 'undefined')) {
			return { x: document.documentElement.scrollLeft, y: document.documentElement.scrollTop };
		}
		return { x: document.body.scrollLeft, y: document.body.scrollTop };
	}
};

// -----------------------------------------------------------------------------

var fields = {
	getAll: function(e) {
		var a = [];
		switch (e.tagName) {
		case 'INPUT':
		case 'SELECT':
			a.push(e);
			break;
		default:
			if (e.childNodes) {
				for (var i = 0; i < e.childNodes.length; ++i) {
					a = a.concat(fields.getAll(e.childNodes[i]));
				}
			}
		}
		return a;
	},
	disableAll: function(e, d) {
		var a = this.getAll(E(e));
		for (var i = a.length - 1; i >= 0; --i) {
			a[i].disabled = d;
		}
	},
	radio: {
		selected: function(e) {
			for (var i = 0; i < e.length; ++i) {
				if (e[i].checked) return e[i];
			}
			return null;
		},
		find: function(e, value) {
			for (var i = 0; i < e.length; ++i) {
				if (e[i].value == value) return e[i];
			}
			return null;
		}
	}
};

// -----------------------------------------------------------------------------
var __redirect__ = null;
function redirectPage()
{
	window.location.replace(__redirect__);	
//	show_confirm(__redirect__);
}

var form = {
	submitHidden: function(url, fields) {
		var fom, body;
		
		fom = document.createElement('FORM');
		fom.action = url;
		fom.method = 'post';
		for (var f in fields) {
			var e = document.createElement('INPUT');
			e.type = 'hidden';
			e.name = f;
			e.value = fields[f];
			fom.appendChild(e);
		}
		body = document.getElementsByTagName('body')[0];
		fom = body.appendChild(fom);
		this.submit(fom, 1);
		body.removeChild(fom);
	},

	disableAll: function(fom) {
		var i, f;
		
		for (i = 0; i < fom.elements.length; i++) {
			f = fom.elements[i];
			
			if(f.name.substr(0, 1) == '_') continue;
			
			f.disabled = true;
		}
	},

	submit: function(fom, async, url) {
		
		fom = E(fom);
		if (isLocal()) {
			this.dump(fom, async, url);
			return;
		}		

		//FIXME: shandy
//		if (this.xhttp) return;
		if (this.xhttp) delete this.xhttp;

		var v, f, i, wait, msg, sb, cb;

		v = ['_ajax=1'];
		wait = 5;
		__redirect__ = null;
		for (var i = 0; i < fom.elements.length; i++) {
			f = fom.elements[i];
			if ((f.disabled) || (f.name == '') || (f.name.substr(0, 2) == 'f_')) continue;
			
			if ((f.tagName == 'INPUT') && ((f.type == 'CHECKBOX') || (f.type == 'RADIO')) && (!f.checked)) continue;
			
			if (f.name == '_nextwait') {
				wait = f.value * 1;
				if (isNaN(wait)) wait = 5;
				else wait = Math.abs(wait);
				continue;
			}
			
			if (f.name == '_redirect') {
				__redirect__ = f.value;
				continue;
			}
			
			v.push(escapeCGI(f.name) + '=' + escapeCGI(f.value));
		}

		if ((sb = E('save-button')) != null) sb.disabled = 1;
		if ((cb = E('cancel-button')) != null) cb.disabled = 1;

		//if ((!async) || (!useAjax())) {
		if ((!useAjax())) {
			if (url) fom.action = url;
			fom.submit();
			return;
		}
		

		//show_info(infomsg.doing, wait);
		var ip_changed;
		if ((ip_changed = cookie.get('changing_ip')) == null){
			ip_changed = 0;
		}
		if (ip_changed == 0)
			show_doing();
		else{
			show_info(infomsg.newip, 2);
			cookie.set('changing_ip', 0);
		}

		if ((!async) ) {/* FixMe: not a real async! */
			if (url) fom.action = url;
			fom.submit();
			return;
		}
		
		this.xhttp = new XmlHttp();
		this.xhttp.onCompleted = function(text, xml) {
			var r;
		
			if ((sb = E('save-button')) != null) sb.disabled = 0;
			if ((cb = E('cancel-button')) != null) cb.disabled = 0;
//			if (text.match(/@msg:(.+)/)) show_info(escapeHTML(RegExp.$1), wait);

			if (r = text.match(/@msg:(.+)/)) {
				
				//top.showResult(r[1], wait);
				top.showResult(r[1], 2);
			
			}else{
				show_info(infomsg.saved, 1);
			}

			form.xhttp = null;
		}
		this.xhttp.onError = function(x) {
			if (url) fom.action = url;
			fom.submit();
		}

		//alert("param: " + v.join('&'));
		this.xhttp.post(url ? url : fom.action, v.join('&'));
	},

	dump: function(fom, async, url) {
	}
};

// -----------------------------------------------------------------------------
function show_alert(content)
{
	var msg = "<center>" + content + "</center><br>";
	
	top.Dialog.alert(msg, 
		{width:300, height:100, okLabel: ui.ok, 
			ok:function(win) {
				return true;
				}
			}
		); 
}

var __info_timer_id = 0;
var __info_msg;
var __info_timeout;

function buildMsg()
{
	return __info_msg + "<br/><br/>" + infomsg.wait + __info_timeout + " " + ui.seconds + " ...";
}

function infoTimeout() {
	__info_timeout--; 
	if (__info_timeout >0) {
		top.Dialog.setInfoMessage(buildMsg());
		__info_timer_id = setTimeout(infoTimeout, 1000) 
	}
	else { 
		top.Dialog.closeInfo();
		if (__redirect__) redirectPage();
		__info_timer_id = 0;
	}
}

function show_confirm(content)
{
	return confirm(content);
}

function show_info(content, timeout)
{	
	__info_msg = content;
	__info_timeout = timeout;


	clearTimeout(__info_timer_id);
	__info_timer_id = 0;

	clearTimeout(__waiting_timer_id);
	__waiting_timer_id = 0;

	
	top.Dialog.closeInfo();
	top.Dialog.info(buildMsg(), {width:250, height:100, showProgress: true});
			
	__info_timer_id = setTimeout(infoTimeout, 1000);
}

var __waiting_timer_id = 0;
var __info_waiting;
var __info_wait_time;
function buildMsg2()
{
	return __info_waiting + "<br/><br/>" + __info_wait_time + " " + ui.seconds + " ...";
}
function infoTimeout2() {

	__info_wait_time++; 

	top.Dialog.setInfoMessage(buildMsg2());
	__waiting_timer_id = setTimeout(infoTimeout2, 1000);

}

function show_doing()
{
	__info_waiting = infomsg.doing;
	__info_wait_time = 0;


	clearTimeout(__info_timer_id);
	__info_timer_id = 0;

	clearTimeout(__waiting_timer_id);
	__waiting_timer_id = 0;

	top.Dialog.closeInfo();
	top.Dialog.info(buildMsg2(), {width:250, height:100, showProgress: true});
	__waiting_timer_id = setTimeout(infoTimeout2, 1000) ;
}

var ferror = {
	set: function(e, message, quiet) {
		if ((e = E(e)) == null) return;
		e._error_msg = message;
		e._error_org = e.title;
		e.title = message;
		elem.addClass(e, 'error');
		if (!quiet) this.show(e);
	},

	clear: function(e) {
		if ((e = E(e)) == null) return;
		e.title = e._error_org || '';
		elem.removeClass(e, 'error');
		e._error_msg = null;
		e._error_org = null;
	},

	clearAll: function(e) {
		for (var i = 0; i < e.length; ++i)
			this.clear(e[i]);
	},
	
	show: function(e) {
		if ((e = E(e)) == null) return;
		if (!e._error_msg) return;
		elem.addClass(e, 'error-focused');
		e.focus();
//		alert(e._error_msg);
		show_alert(e._error_msg);
//	show_info(e._error_msg, 5);
		elem.removeClass(e, 'error-focused');
	},

	ok: function(e) {
		if ((e = E(e)) == null) return 0;
        return !e._error_msg;
	}
};

// -----------------------------------------------------------------------------
function haveChineseChar(str)
{
	var cArr = str.match(/[^\x00-\xff]/ig);
	
	if (cArr != null){
		return true;
	}else{
		return false;
	}
}

function v_f_cn_text(f, quiet)
{	
	if (haveChineseChar(f.value)){
		ferror.set(f, errmsg.cn_chars, quiet);
		return 0;
	}

	ferror.clear(f);
	return 1;
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
}

function isInt(str)
{
	var reg = /^-?\d+$/;
	return reg.test(str);
}
function  _v_f_numeric(f, quiet)
{
	if (isInt(f.value) == 0){
		ferror.set(f, errmsg.num, quiet);
		return 0;
	}

	ferror.clear(f);
	return 1;
}

function _v_f_range(f, quiet, min, max)
{
	var v;
	v = f.value * 1;
	if ((isNaN(v)) || (v < min) || (v > max)) {
		ferror.set(f, ui.invalid + '. ' + ui.valid_range + ': ' + min + '-' + max, quiet);
		return 0;
	}
	ferror.clear(f);
	return 1;
}

function _v_range(e, quiet, min, max, name)
{
	var v;

	if ((e = E(e)) == null) return 0;
	v = e.value * 1;
	if ((isNaN(v)) || (v < min) || (v > max)) {
		ferror.set(e, ui.invalid + '. ' + ui.valid_range + ': ' + min + '-' + max, quiet);
		return 0;
	}
	e.value = v;
	ferror.clear(e);
	return 1;
}

function v_range(e, quiet, min, max)
{
	return _v_range(e, quiet, min, max, 'number');
}


function v_f_number(f, quiet, can_empty, min, max)
{
	if (can_empty == false){
		if (v_f_length(f, quiet, 1) == 0) return 0;
	}else{
		if (v_f_empty(f)) return 1;
	}

	if (v_f_cn_text(f, quiet) == 0) return 0;
	if (_v_f_numeric(f, quiet) == 0) return 0;

	return _v_f_range(f, quiet, min, max);
}

function v_port(e, quiet)
{
	return _v_range(e, quiet, 1, 0xFFFF, 'port');
}

function v_octet(e, quiet)
{
	return _v_range(e, quiet, 1, 254, 'address');
}

function v_macip(e, quiet, bok, ipp)
{
	var s, a, b, c, d, i;

	if ((e = E(e)) == null) return 0;
	s = e.value.replace(/\s+/g, '');

	if ((a = fixMAC(s)) != null) {
		if (isMAC0(a)) {
			if (bok) {
				e.value = '';
			}
			else {
				ferror.set(e, 'Invalid MAC or IP address');
				return false;
			}
		}
        else e.value = a;
		ferror.clear(e);
		return true;
	}

	a = s.split('-');
	if (a.length > 2) {
		ferror.set(e, errmsg.ip_range, quiet);
		return false;
	}
	c = 0;
	for (i = 0; i < a.length; ++i) {
		b = a[i];
		if (b.match(/^\d+$/)) b = ipp + b;

		b = fixIP(b);
		if (!b) {
			ferror.set(e, errmsg.ip, quiet);
			return false;
		}

		if (b.indexOf(ipp) != 0) {
			ferror.set(e, 'IP address outside of LAN', quiet);
			return false;
		}

		d = (b.split('.'))[3];
		if (d <= c) {
			ferror.set(e, errmsg.ip_range, quiet);
			return false;
		}

		a[i] = c = d;
	}
	e.value = ipp + a.join('-');
	return true;
}

function fixIP(ip, x)
{
	var a, n, i;

	a = ip.split('.');
	if (a.length != 4) return null;
	for (i = 0; i < 4; ++i) {
		n = a[i] * 1;
		if ((isNaN(n)) || (n < 0) || (n > 255)) return null;
		a[i] = n;
	}
	//if ((x) && ((a[3] == 0) || (a[3] == 255))) return null;
	return a.join('.');
}

function v_ipnz(e, quiet, x)
{
	if ((e = E(e)) == null) return 0;
	e = E(e);
	if (e.value == '' || e.value == '0.0.0.0'){
		ferror.set(e, errmsg.ip, quiet);
		return false;
	}
	
	return v_ip(e, quiet);
}

function v_ip(e, quiet, x)
{
	var ip;

	if ((e = E(e)) == null) return 0;
	ip = fixIP(e.value, x);
	if (!ip) {
		ferror.set(e, errmsg.ip, quiet);
		return false;
	}
	e.value = ip;
	ferror.clear(e);
	return true;
}

function fix_host_ip(ip)
{
	var a, n, i;

	a = ip.split('.');
	if (a.length != 4) return null;	
	for (i = 0; i < 4; ++i) {
		n = a[i] * 1;
		if ((isNaN(n)) || (n < 0) || (n > 255)) return null;
		if ((i == 0 && n == 0) //0.x.x.x
			|| (i == 0 && n == 127)//127.x.x.x
			|| (i == 0 && n >= 224 && n <= 239)//224.0.0.0 ~ 2399.255.255.255
			|| (i == 0 && n >= 240 )//240.0.0.0 ~255.255.255.255
			) 
			return null;
		if (i == 3 && (n == 0 || n == 255)) return null;//x.x.x.0/x.x.x.255
		a[i] = n;
	}
	//if ((x) && ((a[3] == 0) || (a[3] == 255))) return null;
	return a.join('.');
}
/*
function v_host_ip(e, quiet)
{
	var ip;

	if ((e = E(e)) == null) return 0;
	ip = fix_host_ip(e.value);
	if (!ip) {
		ferror.set(e, errmsg.ip, quiet);
		return false;
	}
	e.value = ip;
	ferror.clear(e);
	return true;
}
*/
function _checkIput_fomartIP(ip)
{
return (ip+256).toString(2).substring(1); //格式化输出(补零)
}


function _v_mask(MaskStr)
{
	/* 有效性校验 */
	var IPPattern = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
	if(!IPPattern.test(MaskStr))return false;

	/* 检查域值 */
	var IPArray = MaskStr.split(".");
	var ip1 = parseInt(IPArray[0], 10);
	var ip2 = parseInt(IPArray[1], 10);
	var ip3 = parseInt(IPArray[2], 10);
	var ip4 = parseInt(IPArray[3], 10);
	
	if ( ip1<0 || ip1>255 /* 每个域值范围0-255 */
	   || ip2<0 || ip2>255
	   || ip3<0 || ip3>255
	   || ip4<0 || ip4>255 ) 
	   return false;

	/* 检查二进制值是否合法 */
	//拼接二进制字符串
	var ip_binary = _checkIput_fomartIP(ip1) + _checkIput_fomartIP(ip2) + _checkIput_fomartIP(ip3) + _checkIput_fomartIP(ip4);
	if(-1 != ip_binary.indexOf("01"))return false;
	return true;
}

function get_bin_ip(ipstr)
{
	var ip = ipstr.split(".");

	var ip_bin = 0;
	var factor = 256*256*256;
	for (var i = 0; i < 4; i++){
		ip_bin += (parseInt(ip[i], 10) * factor);
		factor /= 256;
	}
	return ip_bin;
}

function v_gateway(e, quiet, mask, ip)
{
	var gw = fix_host_ip(e.value);
	if (!gw) {
		ferror.set(e, errmsg.gw, quiet);
		return false;
	}

	
	var mask_bin = get_bin_ip(mask);
	var ip_bin = get_bin_ip(ip);
	var gw_bin = get_bin_ip(gw);

	var ip_mask = ip_bin & mask_bin;
	var gw_mask = gw_bin & mask_bin;	

	if (ip_mask != gw_mask){
		ferror.set(e, errmsg.gw, quiet);
		return false;
	}
	
	ferror.clear(e);
	return true;
	
}

function v_mask(e, quiet)
{
	if (e.value.length == 0){
		ferror.set(e, errmsg.adm3, quiet);
		return false;
	}else if (!_v_mask(e.value)) {
		ferror.set(e, errmsg.netmask, quiet);
		return false;
	}
	ferror.clear(e);
	return true;
}

function v_ipz(e, quiet)
{
	if ((e = E(e)) == null) return 0;
	e = E(e);
	if (e.value == '') e.value = '0.0.0.0';
	else return v_ip(e, quiet);
}

function aton(ip)
{
	var o, x, i;

	// this is goofy because << mangles numbers as signed
	o = ip.split('.');
	x = '';
	for (i = 0; i < 4; ++i) x += (o[i] * 1).hex(2);
	return parseInt(x, 16);
}

// 1.2.3.4, 1.2.3.4/24, 1.2.3.4/255.255.255.0, 1.2.3.4-1.2.3.5
function v_iptip(e, quiet)
{
	var ip, ma, x, y, z;
	var r;

	if ((e = E(e)) == null) return 0;

	ip = e.value;
	ma = '';
	if (r = ip.match(/^(.*)-(.*)$/)) {
		ip = fixIP(r[1]);
		x = fixIP(r[2]);
		if ((ip == null) || (x == null)) {
			ferror.set(e, errmsg.ip_range, quiet);
			return 0;
		}
		ferror.clear(e);
		y = aton(ip);
		z = aton(x);
		if (y == z) {
			e.value = ip;
		}
		else if (z < y) {
			e.value = x + '-' + ip;
		}
		else {
			e.value = ip + '-' + x;
		}
		return 1;
	}
	if (r = ip.match(/^(.*)\/(.*)$/)) {
		ip = r[1];
		ma = r[2];
		x = ma * 1;
		if (!isNaN(x)) {
			if ((x < 0) || (x > 32)) {
				ferror.set(e, errmsg.netmask, quiet);
				return 0;
			}
			if (x==0) ma = '0';
			else ma = x;
		}
		else {
			ma = fixIP(ma);
			if ((ma == null) || (!_v_netmask(ma))) {
				ferror.set(e, errmsg.netmask, quiet);
				return 0;
			}
		}
	}
	ip = fixIP(ip);
	if (!ip) {
		ferror.set(e, errmsg.ip, quiet);
		return 0;
	}
	e.value = ip + ((ma != '') ? ('/' + ma) : '');
	ferror.clear(e);
	return 1;
}

function fixPort(p)
{
	p *= 1;
	if ((isNaN(p)) || (p < 1) || (p > 65535)) return -1;
	return p;
}

function _v_portrange(e, quiet, v)
{
	var x, y;
	var r;

	if (r = v.match(/^(.*)[-:](.*)$/)) {
		x = fixPort(r[1]);
		y = fixPort(r[2]);
		if ((x == -1) || (y == -1)) {
			ferror.set(e, errmsg.port_range + ' : ' + v, quiet);
			return null;
		}
		if (x > y) {
			v = x;
			x = y;
			y = v;
		}
		ferror.clear(e);
		if (x == y) return x;
		return x + '-' + y;
	}

	v = fixPort(v);
	if (v == -1) {
		ferror.set(e, errmsg.port_range_info, quiet);
		return null;
	}

	ferror.clear(e);
	return v;
}

function v_portrange(e, quiet)
{
	var v;

	if ((e = E(e)) == null) return 0;
	v = _v_portrange(e, quiet, e.value);
	if (v == null) return 0;
	e.value = v;
	return 1;
}

function v_iptport(e, quiet)
{
	var a, i, v;

	if ((e = E(e)) == null) return 0;

	a = e.value.split(/,/);
	for (i = 0; i < MIN(a.length, 10); ++i) {
		v = _v_portrange(e, quiet, a[i]);
		if (v == null) return 0;
		a[i] = v;
	}
	if (a.length == 0) {
		ferror.set(e, 'Expecting a list of ports or port range.', quiet);
		return 0;
	}
	e.value = a.join(',');
	ferror.clear(e);
	return 1;
}

function _v_netmask(mask)
{
	var v = aton(mask) ^ 0xFFFFFFFF;
	return (((v + 1) & v) == 0);
}

function v_netmask(e, quiet)
{
	var n, b, r;

	if ((e = E(e)) == null) return 0;
	n = fixIP(e.value);
	if (n) {
		if (_v_netmask(n)) {
			e.value = n;
			ferror.clear(e);
			return 1;
		}
	}
	else if (r = e.value.match(/^\s*\/\s*(\d+)\s*$/)) {
		b = r[1] * 1;
		if ((b >= 1) && (b <= 32)) {
			if (b == 32) n = 0xFFFFFFFF;	// js quirk
				else n = (0xFFFFFFFF >>> b) ^ 0xFFFFFFFF;
			e.value = (n >>> 24) + '.' + ((n >>> 16) & 0xFF) + '.' + ((n >>> 8) & 0xFF) + '.' + (n & 0xFF);
			ferror.clear(e);
			return 1;
		}
	}
	ferror.set(e, errmsg.netmask, quiet);
	return 0;
}

function fixMAC(mac)
{
	var t, i;

	mac = mac.replace(/\s+/g, '').toUpperCase();
	if (mac.length == 0) {
		mac = [0,0,0,0,0,0];
	}
	else if (mac.length == 12) {
		mac = mac.match(/../g);
	}
	else {
		mac = mac.split(/[:\-]/);
		if (mac.length != 6) return null;
	}
	for (i = 0; i < 6; ++i) {
		t = '' + mac[i];
		if (t.search(/^[0-9A-F]+$/) == -1) return null;
		if ((t = parseInt(t, 16)) > 255) return null;
		mac[i] = t.hex(2);
	}
	return mac.join(':');
}

function v_mac(e, quiet)
{
	var mac;

	if ((e = E(e)) == null) return 0;
	mac = fixMAC(e.value);
	if ((!mac) || (isMAC0(mac))) {
		ferror.set(e, errmsg.mac, quiet);
		return 0;
	}
	e.value = mac;
	ferror.clear(e);
	return 1;
}

function v_macz(e, quiet)
{
	var mac;

	if ((e = E(e)) == null) return 0;
	mac = fixMAC(e.value);
	if (!mac) {
		ferror.set(e, errmsg.mac, quiet);
		return false;
	}
	e.value = mac;
	ferror.clear(e);
	return true;
}

function v_length(e, quiet, min, max)
{
	var s, n;

	if ((e = E(e)) == null) return 0;
	s = e.value.trim();
	n = s.length;
	if (min == undefined) min = 1;
	if (n < min) {
//		ferror.set(e, 'Invalid length. Please enter at least ' + min + ' character' + (min == 1 ? '.' : 's.'), quiet);
		ferror.set(e, errmsg.len + ' >= ' + min + '.', quiet);
		return 0;
	}
	max = max || e.maxlength;
    if (n > max) {
//		ferror.set(e, 'Invalid length. Please reduce the length to ' + max + ' characters or less.', quiet);
		ferror.set(e, errmsg.len + ' <= ' + max + '.', quiet);
		return 0;
	}
	e.value = s;
	ferror.clear(e);
	return 1;
}

function v_f_empty(f)
{
	var s, n;

	s = f.value.trim();
	n = s.length;

	if (n == 0)
		return 1;
	else
		return 0;
}

function v_f_length(f, quiet, min, max)
{
	var s, n;

	s = f.value.trim();
	n = s.length;
	if (min == undefined) min = 1;
	if (n < min) {
//		ferror.set(e, 'Invalid length. Please enter at least ' + min + ' character' + (min == 1 ? '.' : 's.'), quiet);
		ferror.set(f, errmsg.len + ' > ' + min + '.', quiet);
		return 0;
	}
	max = max || f.maxlength;
    if (n > max) {
//		ferror.set(e, 'Invalid length. Please reduce the length to ' + max + ' characters or less.', quiet);
		ferror.set(f, errmsg.len + ' < ' + max + '.', quiet);
		return 0;
	}
	ferror.clear(f);
	return 1;
}

function _v_f_blank_text(f, quiet)
{
	
	if(f.value .indexOf(" ") >= 0){
		ferror.set(f, errmsg.bad_description, quiet);
		return 0;
	}
	
	ferror.clear(f);
	return 1;	
}

function _v_f_text_quotation (text)
{
	if(text.indexOf("\"") >= 0)
		return 1;
	if(text.indexOf("\'") >= 0)
		return 1;
	return 0;
}

function _v_f_text_backslash(text)
{
	if(text.indexOf("\\") >= 0)
		return 1;
}


function v_f_text_quotation (f, quiet)
{
	if (_v_f_text_quotation (f.value))	{
		ferror.set(f, errmsg.quotxt, quiet);
		return 0;
	}
	if (_v_f_text_backslash (f.value))	{
		ferror.set(f, errmsg.bstxt, quiet);
		return 0;
	}
	ferror.clear(f);
	return 1;
}

function v_f_text(f, quiet, len_min, len_max)
{
	if (_v_f_blank_text(f, quiet) == 0) return 0;
	
	if (v_f_length(f, quiet, len_min, len_max) == 0) return 0;

	//if (!v_f_text_quotation (f, quiet)) return 0;
	return v_f_cn_text(f, quiet);	
}

function v_password(f, quiet, len_min, len_max)
{
	if(f.value .indexOf(" ") >= 0){//have blank char
		ferror.set(f, errmsg.pw_not_blk, quiet);
		return 0;
	}

	if (v_f_length(f, quiet, len_min, len_max) == 0) return 0; 

	return v_f_cn_text(f, quiet);
}


function v_domain(e, quiet)
{
	var s;

	if ((e = E(e)) == null) return 0;
	s = e.value.trim().replace(/\s+/g, ' ');
	if ((s.length > 64) || ((s.length > 0) && (s.search(/[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+\.?/) == -1))) {
		ferror.set(e, errmsg.bad_name, quiet);
		return 0;
	}
	e.value = s;
	ferror.clear(e);
	return 1;
}

function isMAC0(mac)
{
	return (mac == '00:00:00:00:00:00');
}

function v_ip_in_net(e, net, netmask)
{
	return 1;
}

function v_ip_in_mip(e, mip)
{
	return 1;
}

function ip_increase(ip, m)
{
	var ip2;
	
	var a, n, i;

	a = ip.split('.');
	if (a.length != 4) return '';
	
	for (i = 0; i < 4; ++i) {
		n = a[i] * 1;
		if ((isNaN(n)) || (n < 0) || (n > 255)) return '';
		a[i] = n;
	}
	
	a[3] += m & 0xff;
	a[2] += (m>>8) & 0xff;
	a[1] += (m>>16) & 0xff;
	a[0] += (m>>24) & 0xff;

	for (i = 3; i >= 0; i--) {
		if (a[i]>255) {
			a[i] -= 255;
			if (i==0) break;
			a[i-1]++;
		}
	}
	
	return a.join('.');
}

function net_increase(ip, mask)
{
	var ip2;
	
	var a, n, i;
	var m;

	a = mask.split('.');
	if (a.length != 4) return '';
	m = 0;
	for (i = 0; i <4; i++) {
		n = a[i] * 1;
		if ((isNaN(n)) || (n < 0) || (n > 255)) return '';
		m = m * 256.0 + n;
	}

	a = ip.split('.');
	if (a.length != 4) return '';
	ip2 = 0;
	for (i = 0; i < 4 ; i++) {
		n = a[i] * 1;
		if ((isNaN(n)) || (n < 0) || (n > 255)) return '';
		ip2 = ip2 * 256.0 + n;
	}

	//ip2 = ip2 & m;
	m = 0xffffffff - m;
	ip2 = ip2 + m + 1;
	for (i = 3; i >=0; i--) {
		a[i] = ip2 & 0xff;
		ip2 = ip2 /256;
	}
	
	return a.join('.');
}
// -----------------------------------------------------------------------------

function cmpIP(a, b)
{
	if ((a = fixIP(a)) == null) a = '255.255.255.255';
	if ((b = fixIP(b)) == null) b = '255.255.255.255';
	return aton(a) - aton(b);
}

function cmpText(a, b)
{
	if (a == '') a = '\xff';
	if (b == '') b = '\xff';
	return (a < b) ? -1 : ((a > b) ? 1 : 0);
}

function cmpInt(a, b)
{
	a = parseInt(a, 10);
	b = parseInt(b, 10);
	return ((isNaN(a)) ? -0x7FFFFFFF : a) - ((isNaN(b)) ? -0x7FFFFFFF : b);
}

function cmpDate(a, b)
{
	return b.getTime() - a.getTime();
}

// -----------------------------------------------------------------------------

// todo: cleanup this mess

function TGO(e)
{
	return elem.parentElem(e, 'TABLE').gridObj;
}

function tgHideIcons()
{
	var e;
	while ((e = document.getElementById('tg-row-panel')) != null) e.parentNode.removeChild(e);
}

// options = sort, move, delete
function webGrid(tb, options, maxAdd, editorFields)
{
	this.init(tb, options, maxAdd, editorFields);
	return this;
}

webGrid.prototype = {
	init: function(tb, options, maxAdd, editorFields) {
		if (tb) {
			this.tb = E(tb);
			this.tb.gridObj = this;
		}
		else {
			this.tb = null;
		}
		if (!options) options = '';
		this.header = null;
		this.footer = null;
		this.editor = null;
		this.controls = null;
		this.canSort = options.indexOf('sort') != -1;
		this.canMove = options.indexOf('move') != -1;
		this.maxAdd = maxAdd || 100;
//		this.canEdit = (editorFields != null);
		this.canEdit = (options.indexOf('readonly') == -1);
		this.canBeSelected = (!this.canEdit && (options.indexOf('select') != -1));
		this.selectedRowIndex = -1;
		this.selectedColIndex = -1;
//		this.canDelete = (options.indexOf('readonly') == -1) && (this.canEdit || (options.indexOf('delete') != -1));
		this.canDelete = (this.canEdit || (options.indexOf('delete') != -1)) && (options.indexOf('nodelete') == -1);
		this.editorFields = editorFields;
		this.sortColumn = -1;
		this.sortAscending = true;
	},

	_insert: function(at, cells, escCells) {
		var tr, td, c;
		var i, t;
		tr = this.tb.insertRow(at);
		for (i = 0; i < cells.length; ++i) {
			c = cells[i];
			if (typeof(c) == 'string') {
				td = tr.insertCell(i);
				td.className = 'co' + (i + 1);
				if (escCells) td.appendChild(document.createTextNode(c));
					else td.innerHTML = c;
			}
			else {
				tr.appendChild(c);
			}
		}
		return tr;
	},

	updateEditorField: function(i, editorField) {
		this.editorFields[i] = editorField;
		if (this.newEditor) {
			elem.remove(this.newEditor);
			elem.remove(this.newControls);
			this.footer = this.newEditor = null;
			this.newControls = null;
		}
		this.showNewEditor();
	},

	safeUpdateRowEditorField: function(row, i, editorField){
		var f = fields.getAll(row);
		var f_value = [];
		var f_disabled = [];
		for (var j = 0; j < f.length; j++){
			f_value.push(f[j].value);
			f_disabled.push(f[j].disabled);
		}
		
		if (row == this.newEditor){
			this.updateEditorField(i, editorField);
			row = this.newEditor;
		}else if(row == this.editor){//this.editor
			//change field
			this.editorFields[i] = editorField;
			var rowIndex = this.editor.rowIndex;
			//remove old editor
			elem.remove(this.editor);
			this.editor = null;
			//create new editor
			r = this.createEditor('edit', rowIndex, null);
			row = this.editor = r;
			
		}

		f = fields.getAll(row);
		for (var j = 0; j < f.length; ++j) {
			if (f[j].selectedIndex ) f[j].selectedIndex = f_value[j];
			else f[j].value = f_value[j];
			f[j].disabled = f_disabled[j];
		}
	},

	verifyDelete: function(data) {
		return true;
	},

	// header

	headerClick: function(cell) {
		if (this.canSort) {
			this.sort(cell.cellN);
		}
	},

	headerSet: function(cells, escCells) {
		var e, i;

		elem.remove(this.header);
		this.header = e = this._insert(0, cells, escCells);
		e.className = 'header';

		for (i = 0; i < e.cells.length; ++i) {		
			e.cells[i].cellN = i;	// cellIndex broken in Safari
			e.cells[i].onclick = function() { return TGO(this).headerClick(this); };
		}
		return e;
	},

	// footer

	footerClick: function(cell) {
	},

	footerSet: function(cells, escCells) {
		var e, i;

		elem.remove(this.footer);
		this.footer = e = this._insert(-1, cells, escCells);
		e.className = 'footer';
		
		for (i = 0; i < e.cells.length; ++i) {
			e.cells[i].cellN = i;
			e.cells[i].onclick = function() { TGO(this).footerClick(this) };
		}
		return e;
	},

	//
	footerButtonsSet: function(colNum){
		var r, c;

		this.footer = r = this.tb.insertRow(-1);
		r.className = 'controls';

		c = r.insertCell(0);
		c.colSpan = this.header.cells.length;

		c.innerHTML =   '<input type=button  style="width:100px" value=' + ui.add + ' onclick="TGO(this).footerAdd()" id="row-add">  '+ 
								'<input type=button style="width:100px" value=' + ui.mdi + ' onclick="TGO(this).footerModify()" id="row-mod"> '+
								'<input type=button style="width:100px" value=' + ui.del + ' onclick="TGO(this).footerDel()" id="row-del">';
	
		this.selectedColIndex = colNum;
		E('row-mod').disabled = true;
		E('row-del').disabled = true;
	},

	footerAdd: function(){
		//send cmd
		//jump to detail page
		//document.location = 'status-port-rstp.jsp';	

		
	},
	
	footerModify: function(){
		var send_cmd = [];
		var f = this.getAllData();
		if (this.selectedRowIndex < 0 || this.selectedColIndex < 0)
			return;
		var keyVar = f[this.selectedRowIndex][this.selectedColIndex];
		
		//send_cmd.push("show rmon history "+port_cmd_list[f[1].value]);
		
		//E('_send_cmd').value = send_cmd;
		//E('_send_index').value = f[0].value;
		//E('_detail').submit();
	},
	
	footerDel: function(){
		var send_cmd = [];
		var f = this.getAllData();
		if (this.selectedRowIndex < 0 || this.selectedColIndex < 0)
			return;
		var keyVar = f[this.selectedRowIndex][this.selectedColIndex];

		//reload page
	},

	rpUp: function(e) {
		var i;

		e = PR(e);
		TGO(e).moving = null;
		i = e.previousSibling;
		if (i == this.header) return;
		e.parentNode.removeChild(e);
		i.parentNode.insertBefore(e, i);

		this.recolor();
		this.rpHide();
	},

	rpDn: function(e) {
		var i;

		e = PR(e);
		TGO(e).moving = null;
		i = e.nextSibling;
		if (i == this.footer) return;
		e.parentNode.removeChild(e);
		i.parentNode.insertBefore(e, i.nextSibling);

		this.recolor();
		this.rpHide();
	},

	rpMo: function(img, e) {
		var me;

		e = PR(e);
		me = TGO(e);
		if (me.moving == e) {
			me.moving = null;
			this.rpHide();
			return;
		}
		me.moving = e;
		img.style.border = "1px dotted red";
	},
	
	rpDel: function(e) {
		e = PR(e);

		var data = [];

		for (i=0; i<e.cells.length; i++) data.push(e.cells[i].innerHTML);

		if (this.verifyDelete(data)==false) return;

		TGO(e).moving = null;
		e.parentNode.removeChild(e);
		this.recolor();
		this.rpHide();
		this.disableNewEditor(false);
		this.onDataChanged();		
	},

	rpMouIn: function(evt) {
		var e, x, ofs, me, s, n;
		if ((evt = checkEvent(evt)) == null) return;
		me = TGO(evt.target);
		if (me.isEditing()) return;
		if (me.moving) return;
		me.rpHide();
		e = document.createElement('div');
		e.tgo = me;
		e.ref = evt.target;
		e.setAttribute('id', 'tg-row-panel');
		n = 0;
		s = '';
		if (me.canMove) {
			//s = '<img src="images/rpu.gif" onclick="this.parentNode.tgo.rpUp(this.parentNode.ref)" title="' + ui.move_up + '"<img src="images/rpd.gif" onclick="this.parentNode.tgo.rpDn(this.parentNode.ref)" title="' + ui.move_down + '"><img src="images/rpm.gif" onclick="this.parentNode.tgo.rpMo(this,this.parentNode.ref)" title="' + ui.move + '">';
			n += 3;
			s = '<img src="images/rpu.gif" onclick="this.parentNode.tgo.rpUp(this.parentNode.ref)" title="' + ui.move_up + '" /><img src="images/rpd.gif" onclick="this.parentNode.tgo.rpDn(this.parentNode.ref)" title="' + ui.move_down + '" />';
			//n += 2;
		}
		if (me.canDelete) {
			s += '<img src="images/rpx.gif" onclick="this.parentNode.tgo.rpDel(this.parentNode.ref)" title="' + ui.del + '">';
			++n;
		}
		x = PR(evt.target);
		x = x.cells[x.cells.length - 1];
		ofs = elem.getOffset(x);
		n *= 18;
		//e.style.left = (ofs.x + x.offsetWidth - n) + 'px';
		e.style.left = (ofs.x + x.offsetWidth) + 'px';
		e.style.top = ofs.y + 'px';
		e.style.width = n + 'px';
		e.innerHTML = s;
		document.body.appendChild(e);
	},
	
/*	rpMouOut: function(evt) {
		var e, me;
		if ((evt = checkEvent(evt)) == null) return;
		me = TGO(evt.target);
		me.rpHide(); 
	},*/

	rpHide: tgHideIcons,

	//

	onClick: function(cell) {
		if (this.canEdit) {
			if (this.moving) {
				var p = this.moving.parentNode;
				var q = PR(cell);
				if (this.moving != q) {
					var v = this.moving.rowIndex > q.rowIndex;
					p.removeChild(this.moving);
					if (v) p.insertBefore(this.moving, q);
						else p.insertBefore(this.moving, q.nextSibling);
					this.recolor();
				}
				this.moving = null;
				this.rpHide();
				this.onDataChanged();
				return;
			}
			this.edit(cell);
		}

		if (this.canBeSelected){
			var q = PR(cell);
			this.selectedRowIndex = q.rowIndex;			
			this.recolor();
			var o = this.tb.rows[this.selectedRowIndex];
			o.className = 'selected';
			if (this.selectedColIndex != -1){
				E('row-mod').disabled = false;
				E('row-del').disabled = false;
			}
			return;
			//return this.tb.rows[this.selectedRowIndex]._data;
		}
	},

	insert: function(at, data, cells, escCells) {
		var e, i;
		if ((this.footer) && (at == -1)) at = this.footer.rowIndex;
	
		
		e = this._insert(at, cells, escCells);
		e.className = (e.rowIndex & 1) ? 'even' : 'odd';

		for (i = 0; i < e.cells.length; ++i) {
			e.cells[i].onclick = function() { return TGO(this).onClick(this); };
		}
		e._data = data;
		e.getRowData = function() { return this._data; }
		e.setRowData = function(data) { this._data = data; }
		if ((this.canMove) || (this.canEdit) || (this.canDelete)) {
			e.onmouseover = this.rpMouIn;
//			e.onmouseout = this.rpMouOut;
			if (this.canEdit) e.title = infomsg.edt;
		}

		return e;
	},

	//

	insertData: function(at, data) {
		return this.insert(at, data, this.dataToView(data), false);
	},

	dataToView: function(data) {
		var v = [];
        
        for (var i = 0; i < data.length; ++i){
            if( typeof this.editorFields === 'undefined')
                var type = '';
            else
                var type = this.editorFields[i].type;
                
            if( type != 'password')    
                v.push(escapeHTML('' + data[i]));
            else{
                //when type is password and password isn't empty,show 6 point to replace the real password
                if(data[i]!='')
                    v.push('******');
                else
                    v.push('');
            }
        }
		return v;
	},

	dataToFieldValues: function(data) {
		return data;
	},

	fieldValuesToData: function(row) {
		var e, i, data;

		data = [];
		e = fields.getAll(row);
		for (i = 0; i < e.length; ++i) data.push(e[i].value);
		return data;
	},

	//

	edit: function(cell) {
		var sr, er, e, c;

		if (this.isEditing()) return;

		sr = PR(cell);
		sr.style.display = 'none';
		elem.removeClass(sr, 'hover');
		this.source = sr;
		
		er = this.createEditor('edit', sr.rowIndex, sr);
        er.className = 'editor';
		this.editor = er;

		c = er.cells[cell.cellIndex || 0];
		e = c.getElementsByTagName('input');
		if ((e) && (e.length > 0)) {
			try {	// IE quirk
				e[0].focus();
			}
			catch (ex) {
			}
		}

		this.controls = this.createControls('edit', sr.rowIndex);

		this.disableNewEditor(true);
		this.rpHide();
		this.verifyFields(this.editor, true);
	},

	createEditor: function(which, rowIndex, source) {
		var values;

//		if (which == 'edit') values = this.dataToFieldValues(source.getRowData());
		if (which == 'edit' && source != null ) values = this.dataToFieldValues(source.getRowData());

		var row = this.tb.insertRow(rowIndex);
		row.className = 'editor';

		var common = ' onkeypress="return TGO(this).onKey(\'' + which + '\', event)" onchange="TGO(this).onChange(\'' + which + '\', this)"';

		var vi = 0;
		for (var i = 0; i < this.editorFields.length; ++i) {
			var s = '';
			var ef = this.editorFields[i].multi2;
			if (ef){
				for (var j = 0; j < ef.length; ++j) {
					var f = ef[j];

					if (f.prefix) s += f.prefix;
					var attrib = ' class="fi' + (vi + 1) + '" ' + (f.attrib || '');
					if (f.style)
						attrib  += ' style="'+f.style+'" '
					switch (f.type) {
					case 'password':
					case 'text':
						s += '<input  + type=' +f.type + ' maxlength=' + f.maxlen + common + attrib;
						if (which == 'edit'  && source != null ) s += ' value="' + escapeHTML('' + values[vi]) + '">';
							else s += '>';
						break;
					case 'select':
						s += '<select' + common + attrib + '>';
						for (var k = 0; k < f.options.length; ++k) {
							a = f.options[k];
							if (which == 'edit'  && source != null ) {
								s += '<option value="' + a[0] + '"' + ((a[0] == values[vi]) ? ' selected>' : '>') + a[1] + '</option>';
							}
							else {
								s += '<option value="' + a[0] + '">' + a[1] + '</option>';
							}
						}
						s += '</select>';
						break;
					case 'checkbox':
						s += '<input type="checkbox"' + common + attrib;
						if ((which == 'edit') && (source != null ) && (values[vi]=='1')) s += ' checked';
						s += '>';
						break;
					default:
						s += f.custom.replace(/\$which\$/g, which);
					}
					if (f.suffix) s += f.suffix;

					++vi;
				}
			}else{
   				ef = this.editorFields[i].multi;
				if (!ef) ef = [this.editorFields[i]];
				for (var j = 0; j < ef.length; ++j) {
					var f = ef[j];

					if (f.prefix) s += f.prefix;
					var attrib = ' class="fi' + (vi + 1) + '" ' + (f.attrib || '');
					switch (f.type) {
					case 'password':
					case 'text':
						s += '<input  + type=' +f.type + ' maxlength=' + f.maxlen + common + attrib;
						if (which == 'edit'  && source != null ) s += ' value="' + escapeHTML('' + values[vi]) + '">';
							else s += '>';
						break;
					case 'select':
						s += '<select' + common + attrib + '>';
						for (var k = 0; k < f.options.length; ++k) {
							a = f.options[k];
							if (which == 'edit'  && source != null ) {
								s += '<option value="' + a[0] + '"' + ((a[0] == values[vi]) ? ' selected>' : '>') + a[1] + '</option>';
							}
							else {
								s += '<option value="' + a[0] + '">' + a[1] + '</option>';
							}
						}
						s += '</select>';
						break;
					case 'checkbox':
						s += '<input type="checkbox"' + common + attrib;
						if ((which == 'edit') && (source != null ) && (values[vi]=='1')) s += ' checked';
						s += '>';
						break;
					default:
						s += f.custom.replace(/\$which\$/g, which);
					}
					if (f.suffix) s += f.suffix;

					++vi;
				}
			}
			
 			var c = row.insertCell(i);
			c.innerHTML = s;
			if (this.editorFields[i].vtop) c.vAlign = 'top';
		}

		return row;
	},

	createControls: function(which, rowIndex) {
		var r, c;

		r = this.tb.insertRow(rowIndex);
		r.className = 'controls';

		c = r.insertCell(0);
		c.colSpan = this.header.cells.length;
		if (which == 'edit') {
			
			c.innerHTML =
				((this.canDelete)?('<input type=button value=' + ui.del + ' onclick="TGO(this).onDelete()"> &nbsp; '):('') )+
				'<input type=button value=' + ui.ok + ' onclick="TGO(this).onOK()"> ' +
				'<input type=button value=' + ui.cancel + ' onclick="TGO(this).onCancel()">';
		}
		else {
			if (this.canBeSelected)
				c.innerHTML =   '<input type=button  style="width:100px" value=' + ui.add + ' onclick="TGO(this).footerAdd()" id="row-add">  '+ 
								'<input type=button style="width:100px" value=' + 'Modify' + ' onclick="TGO(this).footerModify()" id="row-mod"> '+
								'<input type=button style="width:100px" value=' + 'Delete' + ' onclick="TGO(this).footerDel()" id="row-del">';
			else	
				c.innerHTML =
				'<input type=button id="add_new_row_button" value=' + ui.add + ' onclick="TGO(this).onAdd()">';
		}
		return r;
	},

	removeEditor: function() {
		if (this.editor) {
			elem.remove(this.editor);
			this.editor = null;
		}
		if (this.controls) {
			elem.remove(this.controls);
			this.controls = null;
		}
	},

	showSource: function() {
		if (this.source) {
			this.source.style.display = '';
			this.source = null;
		}
	},

	onChange: function(which, cell) {
		return this.verifyFields((which == 'new') ? this.newEditor : this.editor, true);
	},

	onKey: function(which, ev) {
		switch (ev.keyCode) {
		case 27:
			if (which == 'edit') this.onCancel();
			return false;
		case 13:
			if (((ev.srcElement) && (ev.srcElement.tagName == 'SELECT')) ||
				((ev.target) && (ev.target.tagName == 'SELECT'))) return true;
			if (which == 'edit') this.onOK();
				else this.onAdd();
			return false;
		}
		return true;
	},

	onDataChanged: function() {
		
	},

	jump: function() {

	},

	onDelete: function() {
		var data = [];

		for (i=0; i<this.source.cells.length; i++) data.push(this.source.cells[i].innerHTML);

		if (this.verifyDelete(data)==false) return;

		this.removeEditor();
		elem.remove(this.source);
		this.source = null;
		this.disableNewEditor(false);
		this.onDataChanged();
	},

	onCancel: function() {
		this.removeEditor();
		this.showSource();
		this.disableNewEditor(false);
		this.onDataChanged();
	},

	onOK: function() {
		var i, data, view;

		if (!this.verifyFields(this.editor, false)) return;

		data = this.fieldValuesToData(this.editor);
		view = this.dataToView(data);

		this.source.setRowData(data);
		for (i = 0; i < this.source.cells.length; ++i) {
			this.source.cells[i].innerHTML = view[i];
		}

		this.removeEditor();
		this.showSource();
		this.disableNewEditor(false);
		this.onDataChanged();
	},

	onAdd: function() {
		var data;

		this.moving = null;
		this.rpHide();

		if (!this.verifyFields(this.newEditor, false)) return;

		data = this.fieldValuesToData(this.newEditor);
		this.insertData(-1, data);

		this.disableNewEditor(false);
		this.resetNewEditor();
		this.onDataChanged();
	},

	verifyFields: function(row, quiet) {
		return true;
	},

	showNewEditor: function() {
		var r;

		r = this.createEditor('new', -1, null);
		this.footer = this.newEditor = r;

		r = this.createControls('new', -1);
		this.newControls = r;

		this.disableNewEditor(false);
	},

	disableNewEditor: function(disable) {
		if (this.getDataCount() >= this.maxAdd) disable = true;
		if (this.newEditor) fields.disableAll(this.newEditor, disable);
		if (this.newControls) fields.disableAll(this.newControls, disable);
	},

	resetNewEditor: function() {
		var i, e;

		e = fields.getAll(this.newEditor);
		ferror.clearAll(e);
		for (i = 0; i < e.length; ++i) {
			var f = e[i];
			if (f.selectedIndex) f.selectedIndex = 0;
				else f.value = '';
		}
        try{
            if (e.length) e[0].focus();
        }catch(err){
            //for IE6
            //when a obj is disabled,IE6 can't focus() to it
        }
        
        
	},

	getDataCount: function() {
		var n;
		n = this.tb.rows.length;
		if (this.footer) n = this.footer.rowIndex;
		if (this.header) n -= this.header.rowIndex + 1;
		return n;
	},

	sortCompare: function(a, b) {
		var obj = TGO(a);
		var col = obj.sortColumn;
		var r = cmpText(a.cells[col].innerHTML, b.cells[col].innerHTML);
		return obj.sortAscending ? r : -r;
	},

	sort: function(column) {
		if (this.editor) return;

		if (this.sortColumn >= 0) {
			elem.removeClass(this.header.cells[this.sortColumn], 'sortasc', 'sortdes');
		}
		if (column == this.sortColumn) {
			this.sortAscending = !this.sortAscending;
		}
		else {
			this.sortAscending = true;
			this.sortColumn = column;
		}
		elem.addClass(this.header.cells[column], this.sortAscending ? 'sortasc' : 'sortdes');

		this.resort();
	},

	resort: function() {
		if ((this.sortColumn < 0) || (this.getDataCount() == 0) || (this.editor)) return;

		var p = this.header.parentNode;
		var a = [];
		var i, j, max, e, p;
		var top;

		this.moving = null;

		top = this.header ? this.header.rowIndex + 1 : 0;
		max = this.footer ? this.footer.rowIndex : this.tb.rows.length;
		for (i = top; i < max; ++i) a.push(p.rows[i]);
		a.sort(THIS(this, this.sortCompare));
		this.removeAllData();
		j = top;
		for (i = 0; i < a.length; ++i) {
			e = p.insertBefore(a[i], this.footer);
			e.className = (j & 1) ? 'even' : 'odd';
			++j;
		}
	},

	recolor: function() {
		 var i, e, o;

		 i = this.header ? this.header.rowIndex + 1 : 0;
		 e = this.footer ? this.footer.rowIndex : this.tb.rows.length;
		 for (; i < e; ++i) {
			 o = this.tb.rows[i];
			 o.className = (o.rowIndex & 1) ? 'even' : 'odd';
		 }
	},

	removeAllData: function() {
		var i, count;

		i = this.header ? this.header.rowIndex + 1 : 0;
		count = (this.footer ? this.footer.rowIndex : this.tb.rows.length) - i;
		while (count-- > 0) elem.remove(this.tb.rows[i]);
	},

	getAllData: function() {
		var i, max, data, r;

		data = [];
		max = this.footer ? this.footer.rowIndex : this.tb.rows.length;
		for (i = this.header ? this.header.rowIndex + 1 : 0; i < max; ++i) {
			r = this.tb.rows[i];
			if ((r.style.display != 'none') && (r._data)) data.push(r._data);
		}
		return data;
	},

	isEditing: function() {
		return (this.editor != null);
	}
}


// -----------------------------------------------------------------------------


function xmlHttpObj()
{
	var ob;
	try {
		ob = new XMLHttpRequest();
		if (ob) return ob;
	}
	catch (ex) { }
	try {
		ob = new ActiveXObject('Microsoft.XMLHTTP');
		if (ob) return ob;
	}
	catch (ex) { }
	return null;
}

var _useAjax = -1;
var _holdAjax = null;

function useAjax()
{
	if (_useAjax == -1) _useAjax = ((_holdAjax = xmlHttpObj()) != null);
	return _useAjax;
}

function XmlHttp()
{
	if ((!useAjax()) || ((this.xob = xmlHttpObj()) == null)) return null;
	return this;
}

XmlHttp.prototype = {
    get: function(url, vars) {
		try {
			this.xob.onreadystatechange = THIS(this, this.onReadyStateChange);
			if ((vars) && (vars.length)) url += '?' + vars;
			this.xob.open('GET', url, true);
			this.xob.send(null);
		}
		catch (ex) {
			this.onError(ex);
		}
	},

	post: function(url, vars) {
		try {
			this.xob.onreadystatechange = THIS(this, this.onReadyStateChange);
			this.xob.open('POST', url, true);
			this.xob.send(vars);
		}
		catch (ex) {
			this.onError(ex);
		}
	},

	abort: function() {
		try {
			this.xob.onreadystatechange = function () { }
			this.xob.abort();
		}
		catch (ex) {
		}
	},

	onReadyStateChange: function() {
		try {
			if (typeof(E) == 'undefined') return;	// oddly late? testing for bug...

			if (this.xob.readyState == 4) {
				if (this.xob.status == 200) {
					this.onCompleted(this.xob.responseText, this.xob.responseXML);
				}
				else {
					this.onError('' + (this.xob.status || 'unknown'));
				}
			}
		}
		catch (ex) {
			this.onError(ex);
		}
	},

	onCompleted: function(text, xml) { },
	onError: function(ex) { }
}


// -----------------------------------------------------------------------------


function webTimer(func, ms)
{
	this.tid = null;
	this.onTimer = func;
	if (ms) this.start(ms);
	return this;
}

webTimer.prototype = {
	start: function(ms) {
		this.stop();
		this.tid = setTimeout(THIS(this, this._onTimer), ms);
	},
	stop: function() {
		if (this.tid) {
			clearTimeout(this.tid);
			this.tid = null;
		}
	},

	isRunning: function() {
		return (this.tid != null);
	},

	_onTimer: function() {
		this.tid = null;
		this.onTimer();
	},

	onTimer: function() {
	}
}


// -----------------------------------------------------------------------------


function webRefresh(actionURL, postData, refreshTime, cookieTag)
{
	this.setup(actionURL, postData, refreshTime, cookieTag);
	this.timer = new webTimer(THIS(this, this.start));
}

webRefresh.prototype = {
	running: 0,

	setup: function(actionURL, postData, refreshTime, cookieTag) {
		var e, v;

		this.actionURL = actionURL;
		this.postData = postData;
		this.refreshTime = refreshTime * 1000;
		this.cookieTag = cookieTag;
	},

	start: function() {
		var e;
		var rand = Math.random();
		if ((e = E('refresh-time')) != null) {
			if (this.cookieTag) cookie.set(this.cookieTag, e.value);
			this.refreshTime = e.value * 1000;
		}
		e = undefined;

		this.updateUI('start');

		this.running = 1;
		if ((this.http = new XmlHttp()) == null) {
			reloadPage();
			return;
		}

		this.http.parent = this;

		this.http.onCompleted = function(text, xml) {
			var p = this.parent;

			if (p.cookieTag) cookie.unset(p.cookieTag + '-error');
			if (!p.running) {
				p.stop();
				return;
			}

			p.refresh(text);

			if ((p.refreshTime > 0) && (!p.once)) {
				p.updateUI('wait');
				p.timer.start(Math.round(p.refreshTime));
			}
			else {
				p.stop();
			}
			
			p.errors = 0;
		}

		this.http.onError = function(ex) {
			var p = this.parent;
			if ((!p) || (!p.running)) return;
			
			p.timer.stop();

			if (++p.errors <= 3) {
				p.updateUI('wait');
				p.timer.start(3000);
				return;
			}
			
			if (p.cookieTag) {
				var e = cookie.get(p.cookieTag + '-error') * 1;
				if (isNaN(e)) e = 0;
					else ++e;
				cookie.unset(p.cookieTag);
				cookie.set(p.cookieTag + '-error', e, 1);
				if (e >= 3) {
					alert('XMLHTTP: ' + ex);
					return;
				}
			}

			setTimeout(reloadPage, 2000);
		}

		this.errors = 0;
		this.http.post(this.actionURL+'?'+rand, this.postData);
	},

	stop: function() {
		if (this.cookieTag) cookie.set(this.cookieTag, -(this.refreshTime / 1000));
		this.running = 0;
		this.updateUI('stop');
		this.timer.stop();
		this.http = null;
		this.once = undefined;
	},

	toggle: function(delay) {
		if (this.running) this.stop();
		else this.start(delay);
	},

	updateUI: function(mode) {
		var e, b;

		if (typeof(E) == 'undefined') return;	// for a bizzare bug...

		b = (mode != 'stop') && (this.refreshTime > 0);
		if ((e = E('refresh-button')) != null) {
			e.value = b ? ui.stp : ui.rfresh;
			e.disabled = ((mode == 'start') && (!b));
		}
		if ((e = E('refresh-time')) != null) e.disabled = b;
		if ((e = E('refresh-spinner')) != null) e.style.visibility = b ? 'visible' : 'hidden';
	},

	initPage: function(delay, def) {
		var e, v;

		e = E('refresh-time');
		if (((this.cookieTag) && (e != null)) &&
			((v = cookie.get(this.cookieTag)) != null) && (!isNaN(v *= 1))) {
			e.value = Math.abs(v);
			if (v > 0) v = (v * 1000) + (delay || 0);
		}
		else if (def) {
			v = def;
			if (e) e.value = def;
		}
		else v = 0;

		if (delay < 0) {
			v = -delay;
			this.once = 1;
		}

		if (v > 0) {
			this.running = 1;
			this.refreshTime = v;
			this.timer.start(v);
			this.updateUI('wait');
		}
	}
}


//HHHH.HHHH.HHHH; H:0~9,a~f,A~F
function v_mac2(mac)
{
	var reg = /^([0-9a-fA-F]{4})(([/\s.][0-9a-fA-F]{4}){2})$/; 
 	 return reg.test(mac); 
}

function v_mcast_mac(mac)
{
	var reg = /^(01)([0-9a-fA-F]{2})(([/\s.][0-9a-fA-F]{4}){2})$/; 
 	return reg.test(mac); 
}

function v_igmp_mac(mac)
{
	var reg = /^(0100.5)([eE])([0-9a-fA-F]{2})((.[0-9a-fA-F]{4}))$/; 
 	return reg.test(mac); 
}

function v_mcast_nonigmp_mac(mac)
{
	if (!v_mcast_mac(mac)) return 0;
	return (!v_igmp_mac(mac));
}

function verityMAC(mac)
{
	for(var i = 0; i < 14; i++){
		if (mac.slice(i, i+1) == ''){
			return false;
		}else if (i == 4 || i == 9){
			if (mac.slice(i, i+1) != '.'){
				return false;
			}
		}else{
			if (!((mac.slice(i, i+1) >= '0' && mac.slice(i, i+1) <= '9')
				|| (mac.slice(i, i+1) >= 'a' && mac.slice(i, i+1) <= 'f')
				|| (mac.slice(i, i+1) >= 'A' && mac.slice(i, i+1) <= 'F')
				)){
				return false;
			}
		}
	}

	return true;
}

function verityMcastMAC(mac)
{
	if (!verityMAC(mac)) return false;
	if (mac.slice(0, 2) != '01') return false;

	return true;
}

function _verityUserName(name)
{
	var reg = /^[A-Za-z0-9_]+$/;
	return reg.test(name);
}

function verityUserName(f, quiet)
{
	if (!_verityUserName(f.value)){
		ferror.set(f, errmsg.usrname, quiet);
		return 0;
	}

	ferror.clear(f);
	return 1;
}

function genStdTimeList(id, zero, min)
{
	var b = [];
	var t = [3,4,5,10,15,30,60,120,180,240,300,10*60,15*60,20*60,30*60];
	var i, v;

	if (min >= 0) {
		b.push('<select id="' + id + '"><option value=0>' + zero);
		for (i = 0; i < t.length; ++i) {
			v = t[i];
			if (v < min) continue;
			b.push('<option value=' + v + '>');
			if (v == 60) b.push('1  ' + ui.minute );
				else if (v > 60) b.push((v / 60) + "  " + ui.minutes);
				else b.push(v + "  " + ui.seconds);
		}
		b.push('</select> ');
	}
	document.write(b.join(''));
}

function genStdRefresh(spin, min, exec)
{
	W('<div style="text-align:right">');
	if (spin) W('<img src="css/alert/progress.gif" id="refresh-spinner"> ');
	genStdTimeList('refresh-time', ui.manual_refresh, min);
	W('<input type="button" value="');
	W(ui.rfresh);
	W('" onclick="' + (exec ? exec : 'refreshClick()') + '" id="refresh-button"></div>');
}

function genStdFooter(args)
{
	W("<div id='footer'>");
	W("<span id='footer-msg'></span>");
	W("<input type='button' style='width:100px' value='" + ui.aply + "' id='save-button' onclick='save(" + args + ")'>");
	W("<input type='button' style='width:100px' value='" + ui.cancel + "' id='cancel-button' onclick='reloadPage();'>");	
	W("</div>");
}

function genStdFooterWithBack(args)
{
	W("<div id='footer'>");
	W("<span id='footer-msg'></span>");
	W("<input type='button' style='width:100px' value='" + ui.aply + "' id='save-button' onclick='save(" + args + ")'>");
	W("<input type='button' style='width:100px' value='" + ui.cancel + "' id='cancel-button' onclick='reloadPage();'>");	
	W("<input type='button' style='width:100px' value='" + ui.bk + "' id='back-button' onclick='back();'>");	
	W("</div>");
}
// -----------------------------------------------------------------------------


function _tabCreate(tabs)
{
	var buf = [];
	buf.push('<ul id="tabs">');
	for (var i = 0; i < arguments.length; ++i)
		buf.push('<li><a href="javascript:tabSelect(\'' + arguments[i][0] + '\')" id="' + arguments[i][0] + '">' + arguments[i][1] + '</a>');
	buf.push('</ul><div id="tabs-bottom"></div>');
	return buf.join('');
}

function tabCreate(tabs)
{
	document.write(_tabCreate.apply(this, arguments));
}

function tabHigh(id)
{
	var a = E('tabs').getElementsByTagName('A');
	for (var i = 0; i < a.length; ++i) {
		if (id != a[i].id) elem.removeClass(a[i], 'active');
	}
	elem.addClass(id, 'active');
}

// -----------------------------------------------------------------------------

var cookie = {
	set: function(key, value, days) {
		document.cookie = 'web_' + key + '=' + value + '; expires=' +
			(new Date(new Date().getTime() + ((days ? days : 14) * 86400000))).toUTCString() + '; path=/';
	},

	get: function(key) {
		var r = ('; ' + document.cookie + ';').match('; web_' + key + '=(.*?);');
		return r ? r[1] : null;
	},

	unset: function(key) {
		document.cookie = 'web_' + key + '=; expires=' +
			(new Date(1)).toUTCString() + '; path=/';
	}
};

// -----------------------------------------------------------------------------

function checkEvent(evt)
{
	if (typeof(evt) == 'undefined') {
		// IE
		evt = event;
		evt.target = evt.srcElement;
		evt.relatedTarget = evt.toElement;
	}
	return evt;
}

function W(s)
{
	document.write(s);
}

function E(e)
{
	return (typeof(e) == 'string') ? document.getElementById(e) : e;
}

function PR(e)
{
	return elem.parentElem(e, 'TR');
}

function THIS(obj, func)
{
	return function() { return func.apply(obj, arguments); }
}

function UT(v)
{
	return (typeof(v) == 'undefined') ? '' : '' + v;
}

function escapeHTML(s)
{
	function esc(c) {
		return '&#' + c.charCodeAt(0) + ';';
	}
	return s.replace(/[&"'<>\r\n]/g, esc);//"
}

function escapeCGI(s)
{
	return escape(s).replace(/\+/g, '%2B');	// escape() doesn't handle +
}

function escapeD(s)
{
	function esc(c) {
		return '%' + c.charCodeAt(0).hex(2);
	}
	return s.replace(/[<>|%]/g, esc);
}

function ellipsis(s, max) {
	return (s.length <= max) ? s : s.substr(0, max - 3) + '...';
}

function MIN(a, b)
{
	return a < b ? a : b;
}

function MAX(a, b)
{
	return a > b ? a : b;
}

function fixInt(n, min, max, def)
{
	if (n === null) return def;
	n *= 1;
	if (isNaN(n)) return def;
	if (n < min) return min;
	if (n > max) return max;
	return n;
}

function comma(n)
{
	n = '' + n;
	var p = n;
	while ((n = n.replace(/(\d+)(\d{3})/g, '$1,$2')) != p) p = n;
	return n;
}

function scaleSize(n)
{
	if (isNaN(n *= 1)) return '-';
	if (n <= 9999) return '' + n;
	var s = -1;
	do {
		n /= 1024;
		++s;
	} while ((n > 9999) && (s < 2));
	return comma(n.toFixed(2)) + (['KB', 'MB', 'GB'])[s];
}

function timeString(mins)
{
	var h = Math.floor(mins / 60);
	if ((new Date(2000, 0, 1, 23, 0, 0, 0)).toLocaleString().indexOf('23') != -1)
		return h + ':' + (mins % 60).pad(2);
	return ((h == 0) ? 12 : ((h > 12) ? h - 12 : h)) + ':' + (mins % 60).pad(2) + ((h >= 12) ? ' PM' : ' AM');
}

function nothing()
{
}

// -----------------------------------------------------------------------------

function show_notice1(s)
{
	if (s.length) document.write('<div id="notice1">' + s + '</div><br style="clear:both">');
}

// -----------------------------------------------------------------------------

function myName()
{
	var name, i;

	name = document.location.pathname;
	name = name.replace(/\\/g, '/');	// IE local testing
	if ((i = name.lastIndexOf('/')) != -1) name = name.substring(i + 1, name.length);
	if (name == '') name = 'status-overview.asp';
	return name;
}

function createFieldTableBuf(flags, desc)
{
	var common;
	var i, n;
	var name;
	var id;
	var fields;
	var f;
	var a;
	var buf = [];
	var tr;

	if ((flags.indexOf('noopen') == -1)) buf.push('<table class="fields">');
	for (desci = 0; desci < desc.length; ++desci) {
		var v = desc[desci];

		if (!v) {
			buf.push('<tr><td colspan=2 class="spacer">&nbsp;</td></tr>');
			continue;
		}

		if (v.ignore) continue;

		buf.push('<tr');
		if (v.rid) buf.push(' id="' + v.rid + '"');
		if (v.hidden) buf.push(' style="display:none"');
		buf.push('>');

		if (v.text) {
			if (v.title) {
				buf.push('<td class="title indent' + (v.indent || 1) + '">' + v.title + '</td><td class="content">' + v.text + '</td></tr>');
			}
			else {
				buf.push('<td colspan=2>' + v.text + '</td></tr>');
			}
			continue;
		}

		buf.push('<td class="title indent' + (v.indent ? v.indent : 1) + '">' + v.title + '</td>');

		
		if (v.multitb) fields = v.multitb;
		else if(v.multi) { 
			fields = v.multi; 
			buf.push('<td class="content">');
		}
		else {
			fields = [v];
			buf.push('<td class="content">');
		}
		
		//	buf.push('<td class="content">');
		

		//buf.push('<td class="content">');

		//if (v.multi) fields = v.multi;
		//else fields = [v];

		for (n = 0; n < fields.length; ++n) {
			f = fields[n];

			if(v.multitb) buf.push('<td class="content-tb">');
			
			if (f.prefix) buf.push(f.prefix);

			if ((f.type == 'radio') && (!f.id)) id = '_' + f.name + '_' + n;
				else id = (f.id ? f.id : ('_' + f.name));
			common = ' onchange="verifyFields(this, 1)" id="' + id + '"';
			if (f.attrib) common += ' ' + f.attrib;
			name = f.name ? (' name="' + f.name + '"') : '';

			switch (f.type) {
			case 'checkbox':
				buf.push('<input type="checkbox"' + name + (f.value ? ' checked' : '') + ' onclick="verifyFields(this, 1)"' + common + '>');
				break;
			case 'radio':
				buf.push('<input type="radio"' + name + (f.value ? ' checked' : '') + ' onclick="verifyFields(this, 1)"' + common + '>');
				break;
			case 'password':
			case 'text':
				buf.push('<input type="' + f.type + '"' + name + ' value="' + escapeHTML(UT(f.value)) + '" maxlength=' + f.maxlen + (f.size ? (' size=' + f.size) : '') + common + '>');
				break;
			case 'select':
				buf.push('<select' + name + common + '>');
				for (i = 0; i < f.options.length; ++i) {
					a = f.options[i];
					if (a.length == 1) a.push(a[0]);
					buf.push('<option value="' + a[0] + '"' + ((a[0] == f.value) ? ' selected' : '') + '>' + a[1] + '</option>');
				}
				buf.push('</select>');
				break;
			case 'textarea':
				buf.push('<textarea' + name + common + '>' + escapeHTML(UT(f.value)) + '</textarea>');
				break;
			default:
				if (f.custom) buf.push(f.custom);
				break;
			}
			if (f.suffix) buf.push(f.suffix);

			if(v.multitb) buf.push('</td>');
		}
		if(!v.multitb)
			buf.push('</td>');
		buf.push('</tr>');
	}
	if ((!flags) || (flags.indexOf('noclose') == -1)) buf.push('</table>');
	
	return buf.join('');
}

function createFieldTable(flags, desc)
{
	document.write(createFieldTableBuf(flags, desc));
}


// -----------------------------------------------------------------------------

function reloadPage()
{
	document.location.reload(1);
}

// -----------------------------------------------------------------------------
// debug

function isLocal()
{
	return location.href.search('file://') == 0;
}

function GetText(obj)
{
	document.write(obj);
}

///////////////////////////////////////////////////////////////////////////////////
//var ike_default_policies = [['3des-md5-96', '3DES-MD5-96'], ['aes-md5-96', 'AES-MD5-96']];
var ike_default_policies = [['3des-md5-modp768', '3DES-MD5-DH1'], ['3des-md5-modp1024', '3DES-MD5-DH2'], ['3des-md5-modp1536', '3DES-MD5-DH5'], ['3des-sha1-modp768', '3DES-SHA1-DH1'], ['3des-sha1-modp1024', '3DES-SHA1-DH2'], ['3des-sha1-modp1536', '3DES-SHA1-DH5'], ['aes128-md5-modp768', 'AES128-MD5-DH1'], ['aes128-md5-modp1024', 'AES128-MD5-DH2'], ['aes128-md5-modp1536', 'AES128-MD5-DH5'], ['aes128-sha1-modp768', 'AES128-SHA1-DH1'], ['aes128-sha1-modp1024', 'AES128-SHA1-DH2'], ['aes128-sha1-modp1536', 'AES128-SHA1-DH5'], ['des-md5-modp768', 'DES-MD5-DH1'], ['des-md5-modp1024', 'DES-MD5-DH2'], ['des-md5-modp1536', 'DES-MD5-DH5'], ['des-sha1-modp768', 'DES-SHA1-DH1'], ['des-sha1-modp1024', 'DES-SHA1-DH2'], ['des-sha1-modp1536', 'DES-SHA1-DH5']];
var ipsec_default_policies = [['3des-md5-96', '3DES-MD5-96'], ['3des-sha1-96', '3DES-SHA1-96'], ['aes128-md5-96', 'AES128-MD5-96'], ['aes128-sha1-96', 'AES128-SHA1-96'], ['des-md5-96', 'DES-MD5-96'], ['des-sha1-96', 'DES-SHA1-96'], ['md5-96', 'AH-MD5-96'], ['sha1-m96', 'AH-SHA1-96']];

//var ipsec_auth_types = [['0', ipsec.shared_key],['1', ipsec.cert],['2', ipsec.rsasig]];
var ipsec_auth_types = [['0', ipsec.shared_key],['1', ipsec.cert]];
var ipsec_id_types = [['0', ui.ip],['1', 'User FQDN'], ['2', 'FQDN']];
var ipsec_startup_modes = [['0', ipsec.auto],['1', ipsec.dod],['2', ipsec.passive],['3', ipsec.manual]];
var ipsec_neg_modes = [['0', ipsec.main_mode],['1', ipsec.agg_mode]];
var ipsec_ipsec_protos = [['0', 'ESP'],['1', 'AH']];
var ipsec_ipsec_modes = [['0', ipsec.tunnel_mode],['1', ipsec.transport_mode]];
var ipsec_tunnel_types = [['0', ipsec.host_host],['1', ipsec.host_net],['2', ipsec.net_host],['3', ipsec.net_net]];
var ipsec_tunnel_pfs = [['0', ipsec.none],['1', 'Group 1'],['2','Group 2'],['5','Group 5']];
//var scep_status_list = [['re-enrolling', scep.stat_new],['enrolling',scep.stat_enrolling],['resume-enrolling',scep.stat_resume],['ok',scep.stat_ok]];
var scep_status_list = {'re-enrolling': scep.stat_new, 'enrolling': scep.stat_enrolling, 'resume-enrolling' : scep.stat_resume, 'ok': scep.stat_ok};
var log_prio = {'x': ui.al, '0': ui.emerg, '1': ui.alt, '2': ui.crit, '3': ui.err, '4': ui.warn, '5': ui.notice, '6': ui.info, '7': ui.dbg};
var log_prio_list = [['x', ui.al], ['0', ui.emerg], ['1', ui.alt], ['2', ui.crit], ['3', ui.err], ['4', ui.warn], ['5', ui.notice], ['6', ui.info], ['7', ui.dbg]];
var l2tpc_startup_modes=[['0',l2tpc.auto],['1',l2tpc.dod],['3',l2tpc.manual]];
var pptpc_startup_modes=[['0',pptpc.auto],['1',pptpc.dod],['3',pptpc.manual]];

//////////////////////////////////////////////////////////////////////////////////
// VIF list
var blank_interface = [['']];
var cellular_interface = [];
var eth_interface = [];
var sub_eth_interface = [];
var svi_interface = [];
var xdsl_interface = [];
var gre_interface = [];
var vp_interface = [];
var openvpn_interface = [];
var dot11radio_interface = [];
var bridge_interface = [];

function grid_push_vif_opt_by_type(ifs_list, opt_list)
{
	for (var i = 0; i < ifs_list.length; i++){
			opt_list.push([ifs_list[i][0], ifs_list[i][0]]);
	}
}

function grid_list_all_vif_opts(virtual_interface)
{
	var all_vif_opts = new Array();
	
	for (var i = 0; i < virtual_interface.length; i++){
			all_vif_opts.push([virtual_interface[i][0], virtual_interface[i][0]]);		
	}

	all_vif_opts.sort();
	//alert(all_vif_opts.length);
	//alert(all_vif_opts);
	return all_vif_opts;
}

function grid_vif_opts_add(now_opts_list, new_opt_name)
{
	for (var i = 0; i < now_opts_list.length; i++){
		if (now_opts_list[i][0] == new_opt_name)
			return now_opts_list;
	}
	
	now_opts_list.push([new_opt_name, new_opt_name]);
	now_opts_list.sort();
	return now_opts_list;
}

function grid_vif_opts_sub(now_opts_list, old_opt_name)
{
	for (var i = 0; i < now_opts_list.length; i++){
		if (now_opts_list[i][0] == old_opt_name){
			now_opts_list.splice(i, 1);
			return now_opts_list;
		}
	}
}


////////////////////////////////////////////////////////////////////////////////
// verify functions. 建议优先使用v_info_*函数。

///////////////////////////////////////////////////////////////////
// pre-handle of verify
/*格式化并返回正确的IP字符串，否则返回null*/
function _fmt_ip(ip)
{
	var a, n, i;

	a = ip.split('.');
	if (a.length != 4) return null;

	for (i = 0; i < 4; ++i) {
		if (a[i] == '') return null;
		n = a[i] * 1;
		if ((isNaN(n)) || (n < 0) || (n > 255)) return null;
		a[i] = n;
	}
	return a.join('.');
}



//////////////////////////////////////////////////////////////////
//verify value of the object
/* v_info_string: 校验字符串长度*/
function verify_string_length(e, min_len, max_len)
{
	return  (e.length >= min_len) && (e.length <= max_len) ;
}

/*只允许英文字母、数字和下划线组成的单词，
多个单词之间用空白符分隔。多于一个单词必须用双引号括起来*/
function verify_string_desc(e)
{
	var reg1 =  /^\w+$/;
	var reg2 =  /^"[\w+\s*]+"$/;
	return reg1.test(e.value) || reg2.test(e.value);
}

/*只允许英文字母、数字和下划线组成的单词*/
function verify_word(e)
{
	var reg = /^[\w-]+$/;
	return reg.test(e.value);
}
/*点分十进制格式的IP地址，允许全零或全1地址，不区分地址类别*/
function verify_basic_ip(e)
{
	var ip;
	ip = _fmt_ip(e.value);
	if (ip == null) return 0;
	e.value = ip;
	return 1;
}
/*校验点分十进制格式，并屏蔽本地地址(127.x.x.x)和组播地址(224.x.x.x~255.x.x.x)*/
function verify_host_ip(e)
{
	var ip, a, n, i;
	ip = _fmt_ip(e.value);
	if (ip == null) return 0;

	a = ip.split('.');
	for (i = 0; i < 4; ++i) {
		n = a[i] * 1;
		a[i] = n;
	}
	if ((a[0] == 0) || (a[0] == 127) || (a[0] >= 224)) return 0;
	
	e.value = ip;
	return 1;
}
/*校验子网掩码，允许全零或全1子网掩码*/
function verify_netmask(e)
{
	var ip, a, n, i;
	ip = _fmt_ip(e.value);
	if (ip == null) return 0;

	a = ip.split('.');
	for (i = 0; i < 4; ++i) {
		n = a[i] * 1;
		a[i] = n;
	}
	/* 检查二进制值是否合法 */
	//拼接二进制字符串
	var ip_binary = _checkIput_fomartIP(a[0]) + _checkIput_fomartIP(a[1]) + _checkIput_fomartIP(a[2]) + _checkIput_fomartIP(a[3]);
	if(-1 != ip_binary.indexOf("01"))return 0;
	e.value = ip;
	return 1;
}
/*校验URL*/
function verify_url(e)
{
         var strRegex = "^((https|http|ftp|rtsp|mms)?://)"  
	         + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp鐨剈ser@  
	         + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP褰㈠紡鐨刄RL- 199.194.52.184  
	         + "|" // 鍏佽IP鍜孌OMAIN锛堝煙鍚嶏級 
	         + "([0-9a-z_!~*'()-]+\.)*" // 鍩熷悕- www.  
	         + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 浜岀骇鍩熷悕  
	        + "[a-z]{2,6})" // first level domain- .com or .museum  
	        + "(:[0-9]{1,4})?" // 绔彛- :80  
	        + "((/?)|" // a slash isn't required if there is no file name  
	        + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";  
        var re=new RegExp(strRegex);  
		  //re.test() 
        if (re.test(e.value)){ 
            return 1;  
        }else{  
            return 0;  
        } 
}

/* 校验MAC地址格式:HHHH.HHHH.HHHH; H:0~9,a~f,A~F */
function verify_mac(e)
{
	var reg = /^([0-9a-fA-F]{4})(([/\s.][0-9a-fA-F]{4}){2})$/; 
 	 return reg.test(e.value); 
}

/* 校验MAC地址格式:HH:HH:HH:HH:HH:HH; H:0~9,a~f,A~F */
function verify_std_mac(e)
{
	var reg = /^([0-9a-fA-F]{2})(([/\s:][0-9a-fA-F]{2}){5})$/; 
 	 return reg.test(e.value); 
}

/* 校验多播MAC地址格式including FFFF.FFFF.FFFF  */
function verify_mcast_mac(e)
{
	if (!verify_mac(e)) return 0;
	var a = e.value.split('');
	var i = parseInt(a[1], 16);
	if (i%2) return 1;
	return 0;
}

/* 校验多播MAC地址格式including FFFF.FFFF.FFFF  */
function verify_std_mcast_mac(e)
{
	if (!verify_std_mac(e)) return 0;
	var a = e.value.split(':');
	var i = parseInt(a[0], 16);
	if (i%2) return 1;
	return 0;
}


/* 校验IGMP多播MAC地址格式including FFFF.FFFF.FFFF  */
function verify_igmp_mac(e)
{
	if (!verify_mcast_mac(e)) return 0;
	var a = e.value.split('.');
	if (a[0] != '0100') return 0;
	var b = a[1].split('.');
	if (b[0] != '5' || (b[1] != 'e' && b[1] != 'E')) return 0;
	return 1;
}
/*校验数值范围*/
function verify_num_range(e, min, max)
{
	var v = e.value * 1;
	
	if ((isNaN(v)) || (v < min) || (v > max))
		return 0;
	return 1;
}


/////////////////////////////////////////////////////////////////
//verify and set/clear infomation

function v_info_passwd(e, quiet, can_empty, min_len, max_len)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}

	if (!verify_string_length(e.value, min_len, max_len)) {
		ferror.set(e, errmsg.badPwdLen1 + min_len + errmsg.badPwdLen2 + max_len +errmsg.badPwdLen3, quiet);
		return 0;
	}

	ferror.clear(e);
	return 1;
}

function v_info_word(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}

	if (!verify_word(e)){/*合法字符校验*/
		ferror.set(e, errmsg.badWord, quiet);
		return 0;
	}

	ferror.clear(e);
	return 1;
}

function v_info_directory(e, quiet, can_empty)
{
	var a, i;
	
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}

	a = e.value.split('/');
	for(i = 0; i < a.length; i++) {
		if (!verify_word(a[i])){/*合法字符校验*/
			ferror.set(e, errmsg.badDir, quiet);
			return 0;
		}
	}

	ferror.clear(e);
	return 1;
}
/* v_info_string: 校验字符串，检查字符是否合法
  * 注:不允许中文；字符串长度上限应由输入框最大长度maxlen进行限制
  */
function v_info_description(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}
	
	if (!verify_string_desc(e)){/*合法字符校验*/
		ferror.set(e, errmsg.badDesc, quiet);
		return 0;
	}

	ferror.clear(e);
	return 1;
}

/*校验合法的主机IP地址，不允许为全零、组播及本地地址*/
function v_info_host_ip(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}

	if (!verify_host_ip(e)){
		ferror.set(e, errmsg.hostIp, quiet);
		return 0;
	}
	ferror.clear(e);
	return 1;		
}

/* 只校验IP地址格式，允许全零、全1地址*/
function v_info_ip(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/
	
	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}

	if (!verify_basic_ip(e)){
		ferror.set(e, errmsg.badIp, quiet);
		return 0;
	}

	ferror.clear(e);
	return 1;		
}

/*校验地址掩码，允许全0 和全1掩码*/
function v_info_netmask(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}
	if (!verify_netmask(e)){
		ferror.set(e, errmsg.netmask, quiet);
		return 0;
	}
	ferror.clear(e);
	return 1;	
}


/*校验IP/掩码对，e1、e2必须各自保证合法*/
function v_info_ip_netmask(e1, e2, quiet)
{
	if ((e1 = E(e1)) == null) return 0;
	if ((e2 = E(e2)) == null) return 0;
	var ip = e1.value;
	var mask = e2.value;
	var mask_bin = get_bin_ip(mask);
	var ip_bin = get_bin_ip(ip);

	if (!(~mask_bin)){
		ferror.clear(e1);
		ferror.clear(e2);
		return true;
	}
	
	var ip_mask = ip_bin & (~mask_bin);
	if (!ip_mask){
		ferror.set(e1, errmsg.badIpMask, quiet);
		ferror.set(e2, errmsg.badIpMask, quiet);
		return false;
	}
	
	ferror.clear(e1);
	ferror.clear(e2);
	return true;
}

/* 校验IP或URL */
function v_info_url(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}

	if (verify_host_ip(e) || verify_url(e)){
		ferror.clear(e);
		return 1;	
	}

	ferror.set(e, errmsg.domain_name, quiet);
	return 0;
}


/* HHHH.HHHH.HHHH; H:0~9,a~f,A~F */
function v_info_mac(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}

	if (!v_mac(e)){
		ferror.set(e, errmsg.mac, quiet);
		return 0;
	}
	ferror.clear(e);
	return 1;
}

function v_info_ucast_mac(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}

	if (!verify_std_mac(e)){
		ferror.set(e, errmsg.stdmac, quiet);
		return 0;
	}

	if (verify_std_mcast_mac(e)){
		ferror.set(e, errmsg.ustdmac, quiet);
		return 0;
	}
	ferror.clear(e);
	return 1;
}


function v_info_mcast_mac(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}

	if (!verify_mac(e)){
		ferror.set(e, errmsg.mac, quiet);
		return 0;
	}

	if (!verify_mcast_mac(e)){
		ferror.set(e, errmsg.mMac, quiet);
		return 0;
	}
	ferror.clear(e);
	return 1;
}

function v_info_igmp_mac(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}

	if (!verify_mac(e)){
		ferror.set(e, errmsg.mac, quiet);
		return 0;
	}

	if (!verify_mcast_mac(e)){
		ferror.set(e, errmsg.mMac, quiet);
		return 0;
	}

	if (!verify_igmp_mac(e)){
		ferror.set(e, errmsg.imac, quiet);
		return 0;
	}
	ferror.clear(e);
	return 1;
}

function v_info_num_range(e, quiet, can_empty, min, max)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, ui.invalid + '. ' + ui.valid_range + ': ' + min + '-' + max, quiet);
		return 0;		
	}

	if (!verify_num_range(e, min, max)){
		ferror.set(e, ui.invalid + '. ' + ui.valid_range + ': ' + min + '-' + max, quiet);
		return 0;
	}

	e.value = e.value * 1
	ferror.clear(e);	
	return 1;
}


