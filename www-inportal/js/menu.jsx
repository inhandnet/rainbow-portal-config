var divData = "";
<% ih_user_info(); %>

var operator_priv = 12;

divData +=
/*----------system------------(head)*/
divData +=	"<div id='administration' label='" + menu.administration + "'>";
		/*---system menu---*/
divData +=
		"<div id='status_system' label='" + menu.system + "' value='status-system.jsp'>" + 
			"<div id='status_system' label='" + menu.status_system + "' value='status-system.jsp'></div>" + 
			"<div id='setup_system' label='" + menu.setup_system + "' value='setup-system.jsp'></div>" + 
		"</div>" ;
		
		/*---time menu---*/
divData +=
		"<div id='setup_time' label='" + menu.setup_time + "' value='setup-time.jsp'>" + 
			"<div id='setup_time' label='" + menu.setup_time + "' value='setup-time.jsp'></div>" + 		
			"<div id='setup_sntp' label='" + menu.setup_sntp + "' value='setup-sntp.jsp'></div>" + 			
		"</div>" ;
		
		/*---access menu---*/	
divData +=
		"<div id='setup_create_user' label='" + menu.admin_access + "' value='setup-access-add.jsp'>" + 
			"<div id='setup_create_user' label='" + menu.setup_create_user + "' value='setup-access-add.jsp'></div>" + 
			"<div id='setup_modify_user' label='" + menu.setup_modify_user + "' value='setup-access-modify.jsp'></div>" +
			"<div id='setup_remove_user' label='" + menu.setup_remove_user + "' value='setup-access-remove.jsp'></div>" +
			"<div id='setup_service' label='" + menu.setup_mgmt_service + "' value='setup-mgmt-services.jsp'></div>" +  			
		"</div>" ;
		
		/*---AAA menu---*/	
divData +=
		"<div id='setup_radius' label='" + menu.aaa + "' value='setup-radius.jsp'>" + 
			"<div id='setup_radius' label='" + menu.setup_radius + "' value='setup-radius.jsp'></div>" +		
			"<div id='setup_tacacs' label='" + menu.setup_tacacs + "' value='setup-tacacs.jsp'></div>" +		
			"<div id='setup_ldap' label='" + menu.setup_ldap + "' value='setup-ldap.jsp'></div>" +		
			"<div id='setup_aaa' label='" + menu.setup_aaa + "' value='setup-aaa.jsp'></div>" +		
		"</div>";
		
		/*---config menu---*/	
if (user_info.priv >= operator_priv){		
	divData +=
			"<div id='admin_config' label='" + menu.admin_config + "' value='admin-config.jsp'>" + 
				"<div id='admin_config' label='" + menu.admin_config + "' value='admin-config.jsp'></div>" +		
			"</div>";
}

		/*---device management menu---*/	
if (<%ih_license('ip8')%>) {
	if (user_info.priv >= operator_priv){		
		divData +=
				"<div id='device_management' label='" + menu.rainbow + "' value='setup-rainbow.jsp'>" + 	
					"<div id='device_management' label='" + menu.rainbow + "' value='setup-rainbow.jsp'></div>" +
				"</div>";
	}
}else{
	if (user_info.priv >= operator_priv){		
		divData +=
				"<div id='device_management' label='" + menu.service_ovdp + "' value='service-ovdp.jsp'>" + 	
					"<div id='device_management' label='" + menu.service_ovdp + "' value='service-ovdp.jsp'></div>" +
				"</div>";
	}		
}
		/*---snmp menu---*/	
divData +=
		"<div id='setup_snmp' label='" + menu.setup_snmp + "' value='setup-snmp.jsp'>" + 
			"<div id='setup_snmp' label='" + menu.setup_snmp + "' value='setup-snmp.jsp'></div>" +
		  	"<div id='setup_snmptrap' label='" + menu.setup_snmptrap + "' value='setup-snmptrap.jsp'></div>" +
		   	/*"<div id='setup_snmpmibs' label='" + menu.setup_snmpmibs + "' value='setup-snmpmibs.jsp'></div>" +*/
		"</div>" ;
		
		/*---radius menu---
divData +=
		"<div id='switch_service_radius' label='" + menu.switch_service_radius + "' value='switch-radius.jsp'>" + 
			"<div id='switch_service_radius' label='" + menu.switch_service_radius + "' value='switch-radius.jsp'></div>" + 
		"</div>" ;
		*/
		/*---alarm menu---*/
divData +=
		"<div id='status_alarm' label='" + menu.alarm + "' value='status-alarm.jsp' >" + 	
			"<div id='status_alarm' label='" + menu.status_alarm + "' value='status-alarm.jsp'></div>" + 
			"<div id='setup_alarm_in' label='" + menu.setup_alarm_in + "' value='setup-alarm-in.jsp'></div>" + 
			"<div id='setup_alarm_out' label='" + menu.setup_alarm_out + "' value='setup-alarm-out.jsp'></div>" + 
			"<div id='setup_alarm_map' label='" + menu.setup_alarm_map + "' value='setup-alarm-map.jsp'></div>" + 
		"</div>";
		
		/*---log menu---*/	
divData +=
		"<div id='status_log' label='" + menu.status_log + "' value='status-log.jsp'>" + 
			"<div id='status_log' label='" + menu.status_log + "' value='status-log.jsp'></div>" + 
			"<div id='admin_log' label='" + menu.admin_log + "' value='admin-log.jsp'></div>" + 			
		"</div>";
		/*---scheduler menu---*/		
if(<%ih_license('wlan')%>) {
	if (user_info.priv >= operator_priv){		
	divData +=
		"<div id='scheduler' label='" + menu.schedule + "' value='scheduler.jsp'>" + 
			"<div id='scheduler' label='" + menu.schedule + "' value='scheduler.jsp'></div>" + 
		"</div>";
	}
	}

		/*---upgrd menu---*/			
if (user_info.priv >= operator_priv){		
	divData +=
			"<div id='upgrd' label='" + menu.upgrd + "' value='upgrade.jsp'>" + 
			"</div>";
}		
		/*---reboot menu---*/
if (user_info.priv >= operator_priv){		
	divData +=
			"<div id='reboot' label='" + menu.reboot + "' value='reboot.cgi'>" + 
			"</div>" ;
}

divData +=	"</div>" ;
/*----------system------------(foot)*/	

/*----------ethernet switch------------(head)*/
if(<%ih_license('ethernet5')%>)
divData += 	"<div id='ethernet_switch' label='" + menu.ethernet_switch + "'>";
		/*---ethernet ports---*/	
if(<%ih_license('ethernet5')%>)
divData +=		
		"<div id='status_port' label='" + menu.ethernet_ports + "' value='status-port.jsp'>";
if(<%ih_license('ethernet5')%>)
divData +=			
			"<div id='status_port' label='" + menu.status_port + "' value='status-port.jsp'></div>";
			/*
			"<div id='status_port_statistics' label='" + menu.status_port_statistics + "' value='status-port-statistics.jsp'></div>" +
			"<div id='clear_port_statistics' label='" + menu.clear_port_statistics + "' value='clear-port-statistics.jsp'></div>" +	
			*/
if(<%ih_license('ethernet5')%>)
divData +=				
			"<div id='setup_port_basic' label='" + menu.setup_port_basic + "' value='setup-port-basic.jsp'></div>";
			/*
			"<div id='setup_port_advanced' label='" + menu.setup_port_advanced + "' value='setup-port-advanced.jsp'></div>" +
			*/
if(<%ih_license('ethernet5')%>)
divData +=				
			"<div id='setup_port_mirror' label='" + menu.setup_port_mirror + "' value='setup-port-mirror.jsp'></div>";
if(<%ih_license('ethernet5')%>)
divData +=				
			"<div id='setup_port_storm' label='" + menu.setup_port_storm + "' value='setup-port-storm.jsp'></div>";			
if(<%ih_license('ethernet5')%>)
divData +=			
		"</div>";
		/*---spanning_tree---		
		"<div id='status_bridge_rstp' label='" + menu.spanning_tree + "' value='status-bridge-rstp.jsp'>" + 
			"<div id='status_bridge_rstp' label='" + menu.status_bridge_rstp + "' value='status-bridge-rstp.jsp'></div>" + 
			"<div id='status_port_rstp' label='" + menu.status_port_rstp + "' value='status-port-rstp.jsp'></div>" + 
			"<div id='setup_stp' label='" + menu.setup_stp + "' value='setup-rstp.jsp'></div>" + 
		"</div>" +

		/*---static port security---
		"<div id='setup_security' label='" + menu.port_security + "' value='setup-port-security.jsp'>"+
			"<div id='setup_security' label='" + menu.port_security + "' value='setup-port-security.jsp'></div>" +
		"</div>" +
		/*---802.1x---
		"<div id='setup-dot1x' label='" + menu.setup_dot1x + "' value='setup-dot1x.jsp'>"+
			"<div id='setup-dot1x' label='" + menu.setup_dot1x + "' value='setup-dot1x.jsp'></div>" +
		"</div>" +		
		/*---mac_address_table---
		"<div id='setup_mac' label='" + menu.mac_address_table + "' value='switch-mac.jsp'>" + 
			"<div id='setup_mac' label='" + menu.setup_mac + "' value='switch-mac.jsp'></div>" +
			"<div id='setup_dynamic_mac' label='" + menu.setup_dynamic_mac + "' value='switch-dynamic-mac.jsp'></div>" +
//			"<div id='setup_security' label='" + menu.setup_macfilter + "' value='setup-port-security.jsp'></div>" +
		"</div>" +	
		*/		
if(<%ih_license('ethernet5')%>)
divData += 	"</div>" ;
/*----------ethernet switch------------(foot)*/


/*----------Network------------(head)*/
divData +=
 "<div id='network' label='" + menu.network + "'>" ;
		/*---ETHERNET---*/	
if (!<%ih_license('ip8')%>) {
		divData +=
		"<div id='status_eth' label='" + menu.eth + "' value='status-eth.jsp'>" + 
			"<div id='status_eth' label='" + menu.stat + "' value='status-eth.jsp'></div>" +
			"<div id='setup_eth1' label='" + menu.eth1 + "' value='setup-eth1.jsp'></div>";
		if(<%ih_license('ethernet2')%>){
			divData += "<div id='setup_eth2' label='" + menu.eth2 + "' value='setup-eth2.jsp'></div>";
			divData += "<div id='setup_bridge' label='" + menu.setup_bridge + "' value='setup-bridge.jsp'></div>";
		}
		divData += "</div>";
}	
if(<%ih_license('ethernet5')%>)
		divData += 
		"<div id='setup_vlan_portmode' label='" + menu.vlan + "' value='setup-vlan-portmode.jsp'>" + 
			"<div id='setup_vlan_portmode' label='" + menu.trunk_vlan + "' value='setup-vlan-portmode.jsp'></div>" +
			"<div id='setup_vlan' label='" + menu.setup_vlan + "' value='setup-vlan.jsp'></div>" +
		"</div>";
if (<%ih_license('ip8')%>) 
		divData += 
		"<div id='status_eth' label='" + menu.vlan + "' value='status-eth.jsp'>" +
		"<div id='status_eth' label='" + menu.stat + "' value='status-eth.jsp'></div>" + 
			"<div id='setup_vlan' label='" + menu.setup_vlan + "' value='setup-vlan.jsp'></div>" +
		"</div>";		
if(!<%ih_license('en00')%>)		
		divData +=		
		/*---DAIL---*/
		"<div id='status_wan1' label='" + menu.setup_wan1 + "' value='status-wan1.jsp'>" +
			"<div id='status_wan1' label='" + menu.stat+ "' value='status-wan1.jsp'></div>"+
			"<div id='setup_wan1' label='" + menu.setup_wan1 + "' value='setup-wan1.jsp'></div>" +
		"</div>" ;
		divData +=
		/*---PPPOE---*/
		"<div id='status_pppoe' label='" + menu.setup_pppoe + "' value='status-pppoe.jsp'>" +
			"<div id='status_pppoe' label='" + menu.stat + "' value='status-pppoe.jsp'></div>" +
			"<div id='setup_pppoe' label='" + menu.setup_pppoe + "' value='setup-pppoe.jsp'></div>" +
		"</div>";
		/*---WLAN---*/
if(<%ih_license('wlan')%>) {
		divData += 
		"<div id='status_wlan0' label='" + menu.setup_wlan0 + "' value='status-wlan0.jsp'>" +
			"<div id='status_wlan0' label='" + menu.stat + "' value='status-wlan0.jsp'></div>" +
			"<div id='setup_wlan0' label='" + menu.setup_wlan0 + "' value='setup-wlan0.jsp'></div>" +
			"<div id='setup_wlan0_ip' label='" + menu.setup_wlan0_ip + "' value='setup-wlan0-ip.jsp'></div>" +
			"<div id='status_wlan0_ssid' label='" + menu.status_ssid + "' value='status-wlan0-ssid.jsp'></div>" +
		"</div>";
}
				
if(<%ih_license('wlan')%>) {
		/*---Portal---*/
		divData +=
		"<div id='setup_portal_nc' label='" + menu.setup_portal_nc + "' value='setup-portal-wd.jsp'>" + 
			"<div id='setup_portal_nc' label='" + menu.setup_portal_nc + "' value='setup-portal-wd.jsp'></div>" +
		"</div>";	
}

		divData +=
		/*---LOOPBACK---*/
		"<div id='setup_lo0' label='" + menu.setup_lo0 + "' value='setup-lo0.jsp'>" + 
			"<div id='setup_lo0' label='" + menu.setup_lo0 + "' value='setup-lo0.jsp'></div>" +
		"</div>" ;
		
		divData +=
		/*---DHCP---*/
		"<div id='status_dhcp' label='" + menu.setup_dhcp + "' value='status-dhcp.jsp'>" +
			"<div id='status_dhcp' label='" + menu.status_dhcp + "' value='status-dhcp.jsp'></div>" +
			"<div id='setup_dhcp' label='" + menu.setup_dhcpserver + "' value='setup-dhcp.jsp'></div>" +
			"<div id='setup_dhcprelay' label='" + menu.setup_dhcprelay + "' value='setup-dhcprelay.jsp'></div>" +
			"<div id='setup_dhcpc' label='" + menu.setup_dhcpclient + "' value='setup-dhcpclient.jsp'></div>" +
		"</div>" +
		/*---DNS---*/
		"<div id='setup_dns' label='" + menu.setup_dns + "' value='setup-dns.jsp'>" + 
			"<div id='setup_dns' label='" + menu.setup_dnsserver + "' value='setup-dns.jsp'></div>" +
 			"<div id='setup_dnsrelay' label='" + menu.setup_dnsrelay + "' value='setup-dnsrelay.jsp'></div>" +
		"</div>" +	
		/*---DDNS---*/
		"<div id='status_ddns' label='" + menu.setup_ddns + "' value='status-ddns.jsp'>" + 
			"<div id='status_ddns' label='" + menu.stat + "' value='status-ddns.jsp'></div>" +
			"<div id='setup_ddns' label='" + menu.setup_ddns + "' value='setup-ddns.jsp'></div>" +
		"</div>";	
		/*---SMS---*/
if(!<%ih_license('en00')%>)
		divData +=
		"<div id='setup_sms_basic' label='" + menu.setup_sms + "' value='setup-sms-basic.jsp'>" + 
			"<div id='setup_sms_basic' label='" + menu.setup_sms_basic + "' value='setup-sms-basic.jsp'></div>" +
		"</div>";
divData +=	"</div>" ;	
/*----------Network------------(foot)*/

/*----------Link Backup------------(head)*/
divData +=
	"<div id='backup' label='" + menu.link_backup + "'>" + 
		/*---SLA---*/
		"<div id='status_sla' label='" + menu.setup_sla + "' value='status-sla.jsp'>" + 
			"<div id='status_sla' label='" + menu.status_sla + "' value='status-sla.jsp'></div>" +	
			"<div id='setup_sla' label='" + menu.setup_sla + "' value='setup-sla.jsp'></div>" +
		"</div>" +	
		/*---Track---*/
		"<div id='status_track' label='" + menu.setup_track + "' value='status-track.jsp'>" + 
			"<div id='status_track' label='" + menu.status_track + "' value='status-track.jsp'></div>" +	
			"<div id='setup_track' label='" + menu.setup_track + "' value='setup-track.jsp'></div>" +
		"</div>" +	
		/*---vrrp---*/
		"<div id='status_vrrp' label='" + menu.setup_vrrp + "' value='status-vrrp.jsp'>" + 
			"<div id='status_vrrp' label='" + menu.status_vrrp + "' value='status-vrrp.jsp'></div>" +	
			"<div id='setup_vrrp' label='" + menu.setup_vrrp + "' value='setup-vrrp.jsp'></div>" +
		"</div>" +	
		/*---interface backup---*/
		"<div id='setup_if_backup' label='" + menu.setup_if_backup + "' value='setup-if-backup.jsp'>" + 
			"<div id='setup_if_backup' label='" + menu.setup_if_backup + "' value='setup-if-backup.jsp'></div>" +
		"</div>" +	
	"</div>" ;
/*----------Link Backup------------(foot)*/

/*----------Route------------(head)*/	
divData +=
	"<div id='route' label='" + menu.route + "'>" + 
		/*---Static Route---*/
		"<div id='status_route' label='" + menu.setup_static_route + "' value='status-route.jsp'>" + 
			"<div id='status_route' label='" + menu.status_route + "' value='status-route.jsp'></div>" +	
			"<div id='setup_static_route' label='" + menu.setup_static_route + "' value='setup-static-route.jsp'></div>" +
		"</div>" +	
		/*---Dynamic Route---*/
		"<div id='dyn_status_route' label='" + menu.setup_dyn_route + "' value='status-route.jsp'>" + 
			"<div id='dyn_status_route' label='" + menu.status_route + "' value='status-route.jsp'></div>" +	
			"<div id='setup_dyn_rip' label='" + menu.setup_dyn_rip + "' value='setup-dyn-rip.jsp'></div>" +
			"<div id='setup_dyn_ospf' label='" + menu.setup_dyn_ospf + "' value='setup-dyn-ospf.jsp'></div>" +
			"<div id='setup_dyn_rib' label='" + menu.setup_dyn_rib + "' value='setup-dyn-rib.jsp'></div>" +
		"</div>" +	
		/*---Multicast Route---*/
		"<div id='setup_mcast_route' label='" + menu.setup_mcast_route + "' value='setup-mroute-basic.jsp'>" + 
			"<div id='setup_mroute_basic' label='" + menu.setup_mroute_basic + "' value='setup-mroute-basic.jsp'></div>" +
			"<div id='setup_mroute_igmp' label='" + menu.setup_mroute_igmp + "' value='setup-mroute-igmp.jsp'></div>" +
		"</div>" +										
	"</div>" ;
/*----------Route------------(foot)*/

/*----------Firewall------------(head)*/
divData +=
	"<div id='firewall' label='" + menu.fw + "'>" + 
		/*---FireWall---*/
		"<div id='setup_acl' label='" + menu.fw_acl + "' value='setup-acl.jsp'>" + 
			"<div id='setup_acl' label='" + menu.fw_acl + "' value='setup-acl.jsp'></div>" +
		"</div>" +	
		"<div id='setup_nat' label='" + menu.fw_nat + "' value='setup-nat.jsp'>" + 
			"<div id='setup_nat' label='" + menu.fw_nat + "' value='setup-nat.jsp'></div>" +
		"</div>" +	
	"</div>" ;
/*----------Firewall------------(foot)*/

/*----------QoS------------(head)*/
divData +=
	"<div id='qos' label='" + menu.qos + "'>" + 
		/*---L2 Quality of Service
		"<div id='setup_qos_pri2tc' label='" + menu.l2qos + "' value='setup-qos-pri2tc.jsp'>" + 
			"<div id='setup_qos_pri2tc' label='" + menu.setup_qos_pri2tc + "' value='setup-qos-pri2tc.jsp'></div>" +
			"<div id='setup_qos_dscp2tc' label='" + menu.setup_qos_dscp2tc + "' value='setup-qos-dscp2tc.jsp'></div>" +
			"<div id='setup_qos_interface' label='" + menu.setup_qos_interface + "' value='setup-qos-interface.jsp'></div>" +
		"</div>" +	
		---*/
		/*---L3 Quality of Service---*/
		"<div id='setup_traffic' label='" + menu.setup_traffic + "' value='setup-traffic.jsp'>" + 
			"<div id='setup_traffic' label='" + menu.setup_traffic + "' value='setup-traffic.jsp'></div>" +	
		"</div>" +			
	"</div>" ;	
/*----------QoS------------(foot)*/

/*----------VPN------------(head)*/
if(<%ih_license('vpn')%>) {
	divData +=
		"<div id='vpn' label='" + menu.vpn + "'>" + 
			/*---IPSec---*/
			"<div id='vpn_ipsec_status' label='" + menu.ipsec + "' value='status-ipsec-tunnel.jsp'>" + 
				"<div id='vpn_ipsec_status' label='" + menu.status_ipsec + "' value='status-ipsec-tunnel.jsp'></div>" +			
				"<div id='vpn_ipsec_p1' label='" + menu.ipsec_p1 + "' value='setup-ipsec-tunnel-p1.jsp'></div>" +			
				"<div id='vpn_ipsec_p2' label='" + menu.ipsec_p2 + "' value='setup-ipsec-tunnel-p2.jsp'></div>" +
				"<div id='vpn_ipsec_setting' label='" + menu.ipsec_setting + "' value='setup-ipsec-tunnel-setting.jsp'></div>" +
			"</div>" +
			/*---GRE---*/
			"<div id='vpn_gre' label='" + menu.gre + "' value='setup-gre-tunnel.jsp'>" + 
				"<div id='vpn_gre' label='" + menu.gre + "' value='setup-gre-tunnel.jsp'></div>" +			
			"</div>" +
			/*---L2TP---*/
			"<div id='status_l2tp' label='" + menu.l2tp + "' value='status-l2tp.jsp'>" + 
				"<div id='status_l2tp' label='" + menu.stat + "' value='status-l2tp.jsp'></div>" +	
				"<div id='vpn_l2tpc' label='" + menu.l2tpc + "' value='setup-l2tpc.jsp'></div>" +			
			"</div>" +
			/*---PPTP---*/
			//"<div id='vpn_pptp' label='" + menu.pptp + "' value='setup-qos-pri2tc.jsp'>" + 
				/*TODO: */
			//"</div>" +
			/*---OPENVPN---*/
			"<div id='status_openvpn' label='" + menu.openvpn + "' value='status-openvpn.jsp'>" + 
				"<div id='status_openvpn' label='" + menu.stat + "' value='status-openvpn.jsp'></div>" +	
				"<div id='openvpn_client' label='" + menu.openvpn_client + "' value='setup-openvpn-client.jsp'></div>" +
			"</div>" +	
			/*---CERT. MGR.---*/
			"<div id='vpn_cert' label='" + menu.cert_mgr + "' value='cert-mgr.jsp'>" + 
				"<div id='vpn_cert' label='" + menu.cert_mgr + "' value='cert-mgr.jsp'></div>" +			
			"</div>" +													
		"</div>" ;
}
/*----------VPN------------(foot)*/

/*----------Industrial------------(head)*/
if(<%ih_license('serial')%> 
	|| <%ih_license('io')%>) {
	divData += "<div id='industrial' label='" + menu.industrial + "'>";
		/*---DTU---*/
		if(<%ih_license('serial')%>) {
			divData +=		
					"<div id='setup_serial' label='" + menu.service_dtu + "' value='setup-serial.jsp'>" + 
						"<div id='setup_serial' label='" + menu.setup_com + "' value='setup-serial.jsp'></div>" +
						"<div id='setup_dtu1' label='" + menu.dtu1 + "' value='setup-dtu1.jsp'></div>" +
						"<div id='setup_dtu2' label='" + menu.dtu2 + "' value='setup-dtu2.jsp'></div>" +
					"</div>";
		}	
		/*----I/O----*/
		if(<%ih_license('io')%>) {
			divData += 
				"<div id='status_io' label='" + menu.service_io + "' value='status-io.jsp'>" + 
					"<div id='status_io' label='" + menu.stat + "' value='status-io.jsp'></div>" +
				"</div>";		
		}
	divData +=	"</div>" ;
}
/*----------Industrial------------(foot)*/

/*----------TOOLS------------(head)*/
divData +=
	"<div id='tools' label='" + menu.tools + "'>" + 
		"<div id='tools_ping' label='" + menu.tools_ping + "' value='tools-ping.jsp'>" +
			"<div id='tools_ping' label='" + menu.tools_ping + "' value='tools-ping.jsp'></div>" + 	
		"</div>" +
		
		"<div id='tools_trace' label='" + menu.tools_trace + "' value='tools-trace.jsp'>" +
			"<div id='tools_trace' label='" + menu.tools_trace + "' value='tools-trace.jsp'></div>" + 	
		"</div>" +
		/*---tools_speed---*/
		"<div id='tools_speed' label='" + menu.tools_speed + "' value='tools-speed.jsp'>" +
			"<div id='tools_speed' label='" + menu.tools_speed + "' value='tools-speed.jsp'></div>" + 	
		"</div>" +
	"</div>" ;
/*----------TOOLS------------(foot)*/

/*----------WIZARDS------------(head)*/
divData +=
	"<div id='wizards' label='" + menu.wizards + "'>" ;

if (!<%ih_license('ip8')%>) {
		divData +=
		"<div id='wizards_lan' label='" + menu.wizards_lan + "' value='wizards-lan.jsp'>" +
			"<div id='wizards_lan' label='" + menu.wizards_lan + "' value='wizards-lan.jsp'></div>" +
		"</div>" +	
		"<div id='wizards_wan0' label='" + menu.wizards_wan0 + "' value='wizards-wan0.jsp'>" +
			"<div id='wizards_wan0' label='" + menu.wizards_wan0 + "' value='wizards-wan0.jsp'></div>" +
		"</div>" ;		
	}
if(!<%ih_license('en00')%>)	{	
	divData +=
		"<div id='wizards_wan1' label='" + menu.wizards_wan1 + "' value='wizards-wan1.jsp'>" +
			"<div id='wizards_wan1' label='" + menu.wizards_wan1 + "' value='wizards-wan1.jsp'></div>" +
		"</div>" ;
	}
if(<%ih_license('vpn')%>) {	
	divData +=	
			"<div id='wizards_ipsec' label='" + menu.wizards_ipsec + "' value='wizards-ipsec.jsp'>" +
				"<div id='wizards_ipsec' label='" + menu.wizards_ipsec + "' value='wizards-ipsec.jsp'></div>" + 
			"</div>" ;
}
divData +=	"</div>" ;
/*----------WIZARDS------------(foot)*/
	
if(<%ih_license('wlan')%>) {
divData +=
	"<div id='personal' label='" + menu.personal + "'>" + 
		/*---Personalized---*/
		"<div id='setup_nginx' label='" + menu.setup_nginx + "' value='setup-nginx.jsp'>" + 
			"<div id='setup_nginx' label='" + menu.setup_nginx + "' value='setup-nginx.jsp'></div>" +
		"</div>" +	
		"<div id='status_rsync' label='" + menu.rsync + "' value='status-remote-sync.jsp'>" + 
			"<div id='status_rsync' label='" + menu.status_rsync + "' value='status-remote-sync.jsp'></div>" +
			"<div id='setup_rsync' label='" + menu.setup_rsync + "' value='setup-remote-sync.jsp'></div>" +
		"</div>";
if (<%ih_license('gps')%>)
divData +=
		"<div id='status_gps' label='" + menu.status_gps + "' value='status-gps.jsp'>" + 
			"<div id='status_gps' label='" + menu.status_gps_pos + "' value='status-gps.jsp'></div>" + 
			"<div id='setup_gps' label='" + menu.setup_gps + "' value='setup-gps.jsp'></div>" + 
		"</div>" ;
divData +=		
	"</div>" ;
}

/*----- end -----*/	
	
