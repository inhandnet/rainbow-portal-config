<% pagehead(menu.schedule) %>

<style type='text/css'>
#schedule-grid .co1{
	width: 100px;
}
#schedule-grid .co2, #schedule-grid .co3, #schedule-grid .co4, #schedule-grid .co5, #schedule-grid .co6, #schedule-grid .co7, #schedule-grid .co8 {
	width: 30px;
}
#schedule-grid .co9, #schedule-grid .co10{
	width: 100px;
}
#schedule-grid .co11{
	width: 100px;
}

</style>

<script type='text/javascript'>

<% nvram("schedule_list,_model_name"); %>

var schedule = new webGrid();
schedule.dataToView = function(data) {
	return [data[0], (data[1] != '0') ? ui.yes : ui.no, (data[2] != '0') ? ui.yes : ui.no,
					(data[3] != '0') ? ui.yes : ui.no, (data[4] != '0') ? ui.yes : ui.no,
					(data[5] != '0') ? ui.yes : ui.no, (data[6] != '0') ? ui.yes : ui.no,
					(data[7] != '0') ? ui.yes : ui.no, data[8], data[9], data[10], data[11]];
}

schedule.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].checked ? 1 : 0, f[2].checked ? 1 : 0, f[3].checked ? 1 : 0, 
		f[4].checked ? 1 : 0, f[5].checked ? 1 : 0, f[6].checked ? 1 : 0, f[7].checked ? 1 : 0, 
		f[8].value, f[9].value, f[10].value, f[11].value];
}

schedule.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	var r, s;
	var t1, t2, i, x;
	var ok = 1;
	
	f[0].value = f[0].value.replace(',', '_');
	f[0].value = f[0].value.replace(';', '_');
	
	for (i=0; i<3 && ok; i++) {
		r = f[8+i].value.split('-');
		if (r.length!=2) {
			ferror.set(f[8+i], errmsg.bad_time, quiet);
			ok = 0;
			break;
		}

		for (x=0; x<2; x++) {
			s = r[x].split(':');
			if (s.length==2) {
				t1 = parseInt(s[0]);
				t2 = parseInt(s[1]);
			}
			if(s.length<=1 || t1<0 || t1>=24 || t2<0 || t2>=60 || (t1==24 && t2!=0)){
				ferror.set(f[8+i], errmsg.bad_time, quiet);
				ok = 0;
				break;
			}else{
				ferror.clear(f[8+i]);
			}
		}
	}
		
	f[11].value = f[11].value.replace(';', '_');
	
	return ok;
}
schedule.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	var data =  schedule.getAllData();
	f[0].value="schedule_" + (data.length + 1);
	f[1].checked = 0;
	f[2].checked = 1;
	f[3].checked = 1;
	f[4].checked = 1;
	f[5].checked = 1;
	f[6].checked = 1;
	f[7].checked = 0;
	f[8].value='9:00-12:00';
	f[9].value='14:00-18:00';
	f[10].value='0:00-0:00';
			
	ferror.clearAll(fields.getAll(this.newEditor));
}
schedule.setup = function() {
	this.init('schedule-grid', ['sort', 'move'], 20, [
		{ type: 'text', maxlen: 15 }, 
		{ type: 'checkbox' },
		{ type: 'checkbox' },
		{ type: 'checkbox' },
		{ type: 'checkbox' },
		{ type: 'checkbox' },
		{ type: 'checkbox' },
		{ type: 'checkbox' },
		{ type: 'text', maxlen: 11 }, 
		{ type: 'text', maxlen: 11 }, 
		{ type: 'text', maxlen: 11 }, 
		{ type: 'text', maxlen: 32 }]);
	this.headerSet([ui.nam, ui.sun, ui.mon, ui.tues, ui.wed, ui.thurs, ui.fri, ui.sat, 
		ui.trange + ' 1', ui.trange + ' 2', ui.trange + ' 3', ui.desc]);
	var schedules = nvram.schedule_list.split(';');
	for (var i = 0; i < schedules.length; ++i) {
		var t = schedules[i].split(',');
		if (t.length == 12) this.insertData(-1, t);
	}
	this.showNewEditor();
	this.resetNewEditor();
}


function verifyFields(focused, quiet)
{
	
	return 1;
}

function save()
{
	if (schedule.isEditing()) return;

	var fom = E('_fom');
	var data = schedule.getAllData();
	var r = [];
	for (var i = 0; i < data.length; ++i) r.push(data[i].join(','));
	fom.schedule_list.value = r.join(';');

	var s = nvram._model_name;
        if (s.substr(3,1)=='C') {
                fom._redirect.value = 'setup-wan2.jsp';
        }else{
                fom._redirect.value = 'setup-wan1.jsp';
        }

	form.submit(fom, 1);
}

function earlyInit()
{
	schedule.setup();
	verifyFields(null, true);
}

function init()
{
	schedule.recolor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_redirect' value=''/>
<input type='hidden' name='_service' value=''>
<input type='hidden' name='schedule_list'>

<div class='section-title' id='schedule-grid-title'>
<script type='text/javascript'>
GetText(menu.schedule);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='schedule-grid'></table>
</div>


<script type='text/javascript'>genStdFooter("");</script>
</form>
<script type='text/javascript'>earlyInit()</script>
</body>
</html>

