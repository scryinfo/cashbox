(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-372fea42"],{"40d9":function(t,a,s){"use strict";s.r(a);var e=function(){var t=this,a=t.$createElement,s=t._self._c||a;return s("div",{staticClass:"original_sign_page"},[s("div",{staticClass:"sign_step1_group"},[s("span",{staticClass:"sign_step1_title"},[t._v(t._s(t.$t("adminStepOne")))])]),s("div",{staticClass:"auth_type_group"},[s("span",{staticClass:"auth_type_key"},[t._v(t._s(t.$t("operationType")))]),s("span",{staticClass:"auth_type_value"},[t._v(t._s(t.authTypeValue))])]),s("div",{staticClass:"auth_input_title_group"},[s("span",{staticClass:"auth_input_content"},[t._v(t._s(t.$t("targetObj")))])]),s("div",{staticClass:"input_message_group"},[s("div",{staticClass:"target_admin_name_group"},[s("span",{staticClass:"target_admin_name_key"},[t._v(t._s(t.$t("username")))]),s("span",{staticClass:"target_admin_name_value"},[t._v(t._s(t.targetTxName))])]),s("div",{staticClass:"target_admin_address_group"},[s("span",{staticClass:"target_admin_address_key"},[t._v(t._s(t.$t("address")))]),s("span",{staticClass:"target_admin_address_value"},[t._v(t._s(t.targetTxAddress))])])]),s("div",{staticClass:"auth_admin_title_group"},[s("span",{staticClass:"auth_admin_title"},[t._v(t._s(t.$t("authTxAdminInfo")))])]),s("div",{staticClass:"auth_admin_group"},[s("span",{staticClass:"auth_admin_key"},[t._v(t._s(t.$t("nowAuthAdminAddress")))]),s("span",{staticClass:"auth_admin_value"},[t._v(t._s(t.nowAdminAddress))])]),s("div",{staticClass:"sign_step2_group"},[s("span",{staticClass:"sign_step3_title"},[t._v(t._s(t.$t("adminStepTwo")))])]),s("div",{staticClass:"sign_btn_group"},[s("van-button",{attrs:{"van-button":"",plain:"",type:"info"},on:{click:t.verifyPwdAndBroadcast}},[t._v(t._s(t.$t("pwdSignAndUpToChain")))])],1),s("van-overlay",{attrs:{show:t.isLoadingAccount}},[s("van-loading",{staticClass:"loading_component",attrs:{type:"spinner",vertical:""}},[t._v(t._s(t.$t("dataLoading")))])],1)],1)},n=[],i=(s("99af"),s("4160"),s("d3b7"),s("ac1f"),s("25f0"),s("5319"),s("159b"),s("bf19"),s("96cf"),s("c964")),o=s("276c"),r=s("e954"),c=s("e1a7"),d=s("f20d"),u=s("920b"),l=s("9ab4"),g=s("60a3"),h=s("2638"),p=s.n(h),_=s("d282"),f=s("ba31"),v=s("b1d2"),m=s("7744"),w=s("34e96"),A=Object(_["a"])("panel"),S=A[0],b=A[1];function T(t,a,s,e){var n=function(){return[s.header?s.header():t(m["a"],{attrs:{icon:a.icon,label:a.desc,title:a.title,value:a.status,valueClass:b("header-value")},class:b("header")}),t("div",{class:b("content")},[s.default&&s.default()]),s.footer&&t("div",{class:[b("footer"),v["c"]]},[s.footer()])]};return t(w["a"],p()([{class:b(),scopedSlots:{default:n}},Object(f["b"])(e,!0)]))}T.props={icon:String,desc:String,title:String,status:String};var y=S(T),C=s("b650"),$=s("d399"),x=(s("fb9c"),s("0147"),s("5f7d"),s("17d1"),s("c2d8"),s("106a")),O=s("36d1"),I=s("8402"),L=s("5487"),k=s("7c42");g["c"].use(y).use(C["a"]).use(m["a"]).use(w["a"]).use($["a"]);var j=function(t){function a(){var t;return Object(o["a"])(this,a),t=Object(c["a"])(this,Object(d["a"])(a).apply(this,arguments)),t.authTypeValue="",t.isLoadingAccount=!0,t.targetTxAddress="",t.targetTxName="",t.nowAdminAddress="",t.waitSignInfo="",t}return Object(u["a"])(a,t),Object(r["a"])(a,[{key:"created",value:function(){this.$store.state.title=this.$t("confirmInfo").toString(),window.nativeSignMsgToJsResult=this.nativeSignMsgToJsResult,this.$store.state.authOriginalTxModel.authType==O["a"].DeleteAdmin?this.authTypeValue=this.$t("deleteAdmin").toString():this.authTypeValue=this.$t("addAdmin").toString()}},{key:"mounted",value:function(){var t=Object(i["a"])(regeneratorRuntime.mark((function t(){var a;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return a=this.$store.state.authOriginalTxModel,this.nowAdminAddress=a.nowAdminAddress,console.log("confirm page this.nowAdminAddress===>"+a.nowAdminAddress+"||"+this.nowAdminAddress),this.targetTxAddress=a.targetTxAddress,this.targetTxName=a.targetTxName,t.next=7,this.loadWaitSignInfo();case 7:this.isLoadingAccount=!1;case 8:case"end":return t.stop()}}),t,this)})));function a(){return t.apply(this,arguments)}return a}()},{key:"loadWaitSignInfo",value:function(){var t=Object(i["a"])(regeneratorRuntime.mark((function t(){return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return console.log("this.$store.state.authOriginalTxModel.authType is===>"+this.$store.state.authOriginalTxModel.authType),this.isLoadingAccount=!0,t.next=4,L["b"].getInstance().assembleAdminSingleMessage(this.$store.state.authOriginalTxModel.authType,this.$store.state.nativeChainAddress,this.targetTxAddress,this.targetTxName);case 4:this.waitSignInfo=t.sent,console.log("this.waitSignInfo is:===》"+this.waitSignInfo),this.isLoadingAccount=!1,this.waitSignInfo&&""!==this.waitSignInfo||(this.waitSignInfo="",k["a"].show(this.$t("assembleDataError").toString())),console.log("this.waitSignInfo is OK===>"+this.waitSignInfo);case 9:case"end":return t.stop()}}),t,this)})));function a(){return t.apply(this,arguments)}return a}()},{key:"verifyPwdAndBroadcast",value:function(){I["a"].getInstance().callNativeSignMsgToJs(this.waitSignInfo)}},{key:"nativeSignMsgToJsResult",value:function(t){var a=this;this.isLoadingAccount=!0,console.log("own_input nativeSignMsgToJsResult===>"+t),L["b"].getInstance().sendToChain(t,(function(t){if(t.isFinalized){console.log("use balance is finished!===>");var s=t.asFinalized;L["b"].getInstance().loadApiPromise().then((function(t){t.query.system.events.at(s).then((function(t){var s=!1;t.forEach((function(t){var e=t.phase,n=t.event,i=n.data,o=n.method,r=n.section;if(a.isLoadingAccount=!1,"contracts"==r&&"ContractExecution"==o){console.log("contracts===>"+i.toJSON()),k["a"].show(a.$t("successUpLoad").toString(),8e3),s=!0;var c=a;setTimeout((function(){c.$router.push({name:"original_process"})}),1e3)}console.log("forEach  =>"+e.toString()+"||section=>"+": ".concat(r,".").concat(o)+i.toString())})),s||k["a"].fail(a.$t("failUpLoad").toString(),8e3)}))}))}return t.isBroadcast&&console.log("status.isBroadcast===>"),t.isDropped?(a.isLoadingAccount=!1,console.log("status.isDropped===>"),void k["a"].show(a.$t("failUpLoad").toString(),8e3)):t.isInvalid?(a.isLoadingAccount=!1,console.log("status.isInvalid!===>"),void k["a"].show(a.$t("failUpLoad").toString(),8e3)):void 0})).catch((function(t){a.isLoadingAccount=!1,console.log("Error reason===>"+t),a.$router.replace({name:"original_entry"}),k["a"].show(a.$t("failUpLoad").toString(),8e3)}))}}]),a}(g["c"]);j=Object(l["a"])([Object(g["a"])({components:{ScanSign:x["a"]}})],j);var M=j,J=M,R=(s("d3da"),s("2877")),N=Object(R["a"])(J,e,n,!1,null,"444bffa0",null);a["default"]=N.exports},"5e2c5":function(t,a,s){},d3da:function(t,a,s){"use strict";var e=s("5e2c5"),n=s.n(e);n.a},db80:function(t,a,s){},fb9c:function(t,a,s){s("a29f"),s("0607"),s("949e"),s("247c"),s("836f"),s("db80")}}]);
//# sourceMappingURL=chunk-372fea42.d90e4e88.js.map